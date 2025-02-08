(in-package :sdl3)

(defun any-prefix-p (string prefixes)
  "Does string have any of the prefix?
If so, return that prefix"
  (some (lambda (prefix)
          (and (uiop:string-prefix-p prefix string) prefix))
        prefixes))

(defun sdl->lsp (str)
  (let ((name (subseq str 4 (length str)))
        (special-substrings (list "GPU" "YUV" "NV" "IO" "RW" "GUID" "SF"
                                  "AVIF" "ICO" "CUR" "BMP" "GIF" "JPG" "JXL" "LBM" "PCX" "PNG" "PNM" "SVG" "QOI" "TGA" "TIF" "XCF" "XPM" "XV" "WEBP"))
        char
        prefix-match)
    (with-output-to-string (str)
      (do ((i 0 (1+ i)))
          ((>= i (length name)))
        (setf char (char name i))
        (cond ((or (lower-case-p char)
                   (digit-char-p char)
                   (char= #\- char))
               (write-char char str))
              ((and (upper-case-p char)
                    (setf prefix-match (any-prefix-p (subseq name i)
                                                     special-substrings)))
               (unless (eql i 0)
                 (write-char #\- str))
               (write-string (string-downcase prefix-match) str)
               (incf i (1- (length prefix-match))))
              ((upper-case-p char)
               (unless (eql i 0)
                 (write-char #\- str))
               (write-char (char-downcase char) str))
              (t (error "Unable to handle at char: ~a" char)))))))

(defmacro defexport-fun (name ret &body body
			 &aux (lsp-name (when (atom name)
					  (create-symbol (read-from-string (sdl->lsp name))))))
  "function define use this just can use outside"
  `(eval-when (:compile-toplevel :load-toplevel :execute) 
     (cffi:defcfun ,(if (listp name)
			name
			`(,name ,lsp-name)) 
	 ,ret
       ,@body)
     (export ',(if (listp name)
		   (second name)
		   lsp-name))))

(defun parse-ctype (tp)
  "parse pointer type"
  (cond ((equal tp '(:pointer :pointer)) `(quote ,tp))
	((and (listp (second tp))
	      (eql (first (second tp)) :pointer))
	 `(quote ,tp))
	((and (listp (second tp))
	      (or (eql (first (second tp)) :struct)
		  (eql (first (second tp)) :union)))
	 `(quote ,(second tp)))
	((keywordp (second tp)) (second tp))
	(t  `(quote ,(second tp)))))

(defun get-input-map (lst)
  "function use to get input arguments in lst
get args list like (foo :int :direction :input)"
  (remove 'nil 
	  (mapcar (lambda (arg)
		      (if (eql (getf arg :direction) :input)
			  (remove 'nil
				  (list (create-symbol '% (first arg)) 
					(parse-ctype (second arg))
					(getf arg :bind-count)))
			  nil))
		  lst)))
(defun get-output-map (lst)
  "function use to get input arguments in lst
get args list like (foo :int :direction :output)"
  (remove 'nil 
	  (mapcar (lambda (arg)
		      (if (eql (getf arg :direction) :output)
			  (list (first arg) (parse-ctype (second arg)))
			  nil))
		  lst)))
(defun get-export-fun-args (args ptr-args)
  "function use to generate wrap function's arguments list"
  (if (null ptr-args)
      args
      (reverse (set-difference args ptr-args))))

(defun translate-output-map (lst)
  "function use to translate output values from c function to lisp"
  (mapcar (lambda (val
		     &aux (tp (second val)))
	      `(cffi:mem-ref ,(first val)
			     ,(cond ((equal tp ''(:pointer :pointer))
				     :pointer)
				    ((and (listp tp)
					  (listp (second tp))
					  (listp (second 
						  (second tp)))
					  (eql (first (second 
						       (second tp)))
					       :pointer))
				     `(quote ,(second 
					       (second tp))))
				    (t tp))))
	  lst))

(defun get-input-args (lst)
  "function use to get input arguments in lst"
  (remove 'nil 
	  (mapcar (lambda (arg)
		      (if (eql (getf arg :direction) :input)
			  (first arg)
			  nil))
		  lst)))

(defun generate-setf (input-map input-args)
  "function use to auto generate set format from c to lisp"
  (when (/= (length input-map) (length  input-args))
    (error "input map and input args are not equal"))
  (mapcar (lambda (im ia
		     &aux (tp (cadadr im)))
	      `(setf (cffi:mem-ref ,(first im) 
				   ,(cond ((equal '(:pointer :pointer) tp) :pointer)
					  ((keywordp tp) tp)
					  (t `(quote ,tp))))
		     ,ia))
	  input-map
	  input-args))

(defun generate-multi-setf (input-map input-args)
  "function use to auto generate set format from c to lisp with list"
  (when (/= (length input-map) (length  input-args))
    (error "input map and input args are not equal"))
  (mapcar (lambda (im ia
		   &aux (tp (second im)))
	    (if (= (length im) 3) ;; if count is 3 it has count
		`(unless (null ,ia)
		   (dotimes (i ,(first (last im)))
		     (setf (cffi:mem-aref ,(first im) 
					  ,(cond ((and (listp tp)
						       (equal (second tp) '(:pointer :pointer)))
						  :pointer)
						 (t tp))
					  i)
			   (elt ,ia i))))
		`(unless (null ,ia)
		   (setf (cffi:mem-ref ,(first im) 
				       ,(cond ((and (listp tp)
						    (equal (second tp) '(:pointer :pointer)))
					       :pointer)
					      (t tp)))
			 ,ia))))
	  input-map
	  input-args))

(defun get-bind-let (args)
  "get the argument from wraped function whitch should be list"
  (remove 'nil 
	  (mapcar (lambda (arg &aux 
				   (bind-v (getf arg :bind-val)))
		      (when bind-v
			`(,(first arg) (length ,bind-v))))
		  args)))

(defun do-translate (export-fun 
		     execute-fun
		     args
		     return-ret
		     ret
		     translate-return)
  "auto generate lisp function"
  (let* ((execute-fun-args (mapcar (lambda (arg)
				     (if (eql (getf arg :direction) :input)
					 `(if (null ,(first arg))
					      (cffi:null-pointer)
					      ,(create-symbol '% (first arg)))
					 (first arg)))
				   args))
	 (bind-let (get-bind-let args) )
	 (input-map (get-input-map args))
	 (input-args (get-input-args args))
	 (output-map (get-output-map args))
	 (output-ptrs (mapcar 'first output-map))
	 (ret-lst (find-if (lambda (arg)
			       (find :ret-count arg))
			   args))
	 (ret-count-val (first ret-lst))
	 (ret-count-type (getf ret-lst  :ret-count))
	 (alloc-map (append input-map 
			    output-map
			    (when ret-lst
			      (list `(,ret-count-val :int))))) ;; usually count use int
	 (export-fun-args (get-export-fun-args
			   (remove 'nil
				   (mapcar (lambda (arg)
					       (when (not (or (getf arg :bind-val)
							      (getf arg :ret-count)))
						 (first arg)))
					   args))
			   output-ptrs)))
    `(progn
       (defun ,export-fun (,@export-fun-args)
	 (let (,@bind-let)
	   (cffi:with-foreign-objects (,@alloc-map)
	     ,@(when input-map
		 (generate-multi-setf input-map input-args))
	     ,(if return-ret
		  `(let ((ret (,execute-fun ,@execute-fun-args)))
		     (values ,(cond (ret-lst `(loop :for i :from 0 :below (cffi:mem-ref ,ret-count-val :int)
						    :collect (cffi:mem-aref ret ,ret-count-type i)))
				    (translate-return `(cffi:mem-ref ret ',(second ret)))
				    (t `ret))
			     ,@ (translate-output-map output-map)))
		  `(progn 
		     (,execute-fun ,@execute-fun-args)
		     (values ,@ (translate-output-map output-map)))))))
       (export ',export-fun))))

(defun gen-cffi-struct-body (body)
  "remove some custom args"
  (mapcar (lambda (bd)
	      (list (first bd) (second bd)))
	  body))

(defmacro defwrap-fun (name ret
		       (&optional
			  (translate nil)
			  (retur-ret nil)
			  (translate-return nil))
		       &body body
		       &aux (cffi-body (gen-cffi-struct-body body)))
  "function define use this, this function need wrap, the translate indiced the function auto translate"
  (let* ((lsp-fun (if (listp name)
		      (second name)
		      (read-from-string (sdl->lsp name)))) ;; export lsp-fun
	 (%lsp-fun (create-symbol '% lsp-fun)))
    `(eval-when (:compile-toplevel :load-toplevel :execute) 
       (cffi:defcfun ,(if (listp name)
			  `(,(first name) ,%lsp-fun)
			  `(,name ,%lsp-fun))
	   ,ret
	 ,@cffi-body)
       ,(when translate
	  (do-translate
	    lsp-fun
	    %lsp-fun
	    body
	    retur-ret
	    ret
	    translate-return)))))

