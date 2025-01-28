(in-package :sdl3)


(defparameter *key-world* '("GL" "EGL"))

(defun get-word-until-lower-case (str
				  &aux (rst ""))
  (dotimes (i (length str))
    (cond ((lower-case-p (char str (1+ i)))
	   (return-from get-word-until-lower-case (values rst (- i 1))))
	  (t (setf rst (string+ rst (char str i))))))
  (values rst (length str)))

(defun sdl->lsp (str)
  "please optimize it"
  (let ((name (subseq str 4 (length str)))
	(lsp-name ""))
    (do ((i 0 (1+ i)))
	((>= i (length name)) lsp-name)
      (setf lsp-name
	    (string+ lsp-name 
		     (cond ((= i 0) (char-downcase (char name i)))
			   ((and (upper-case-p (char name i))
				 (upper-case-p (char name (+ i 1))))
			    ;; just use in gpu file fix it
			    (multiple-value-bind (rst next-i)
				(get-word-until-lower-case (subseq name i))
			      (setf i (+ i next-i))
			      (string+ #\- (string-downcase rst))))
			   ((upper-case-p (char name i))
			    (string+ #\- (char-downcase (char name i))))
			   (t (char name i))))))))

(defmacro defexport-fun (name ret &body body
				    &aux (lsp-name (create-symbol (read-from-string (sdl->lsp name)))))
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
  "parse pointer"
  (cond ((equal tp '(:pointer :pointer)) `(quote ,tp))
	((and (listp (second tp))
	      (or (eql (first (second tp)) :struct)
		  (eql (first (second tp)) :union)
		  (eql (first (second tp)) :pointer)))
	 `(quote ,(second tp)))
	((keywordp (second tp)) (second tp))
	(t  `(quote ,(second tp)))))

(defun get-input-map (lst)
  "function use to get input arguments in lst"
  (remove 'nil 
	  (mapcar #'(lambda (arg)
		      (if (eql (getf arg :direction) :input)
			  (remove 'nil
				  (list (create-symbol '% (first arg)) 
					(parse-ctype (second arg))
					(getf arg :bind-count)))
			  nil))
		  lst)))
(defun get-output-map (lst)
  "function use to get input arguments in lst"
  (remove 'nil 
	  (mapcar #'(lambda (arg)
		      (if (eql (getf arg :direction) :output)
			  (list (first arg) (parse-ctype (second arg)))
			  nil))
		  lst)))
(defun get-export-fun-args (args ptr-args)
  "remove all ptr-args from args"
  (if (null ptr-args)
      args
      (reverse (set-difference args ptr-args))))

(defun translate-output-map (lst)
  (mapcar #'(lambda (val
		     &aux (tp (second val)))
	      `(cffi:mem-ref ,(first val)
			     ,(if (equal tp ''(:pointer :pointer)) 
				  :pointer
				  tp)))
	  lst))

(defun get-input-args (lst)
  "function use to get input arguments in lst"
  (remove 'nil 
	  (mapcar #'(lambda (arg)
		      (if (eql (getf arg :direction) :input)
			  (first arg)
			  nil))
		  lst)))

(defun generate-setf (input-map input-args)
  (when (/= (length input-map) (length  input-args))
    (error "input map and input args are not equal"))
  (mapcar #'(lambda (im ia
		     &aux (tp (cadadr im)))
	      `(setf (cffi:mem-ref ,(first im) 
				   ,(cond ((equal '(:pointer :pointer) tp) :pointer)
					  ((keywordp tp) tp)
					  (t `(quote ,tp))))
		     ,ia))
	  input-map
	  input-args))

(defun generate-multi-setf (input-map input-args)
  (when (/= (length input-map) (length  input-args))
    (error "input map and input args are not equal"))
  (mapcar #'(lambda (im ia
		     &aux (tp (second im)))
	      (if (= (length im) 3) ;; if count is 3 it has count
		  `(dotimes (i ,(first (last im)))
		     (setf (cffi:mem-aref ,(first im) 
					  ,(cond ((and (listp tp)
						       (equal (second tp) '(:pointer :pointer)))
						  :pointer)
						 (t tp))
					  i)
			   (elt ,ia i)))
		  `(setf (cffi:mem-ref ,(first im) 
				       ,(cond ((and (listp tp)
						    (equal (second tp) '(:pointer :pointer)))
					       :pointer)
					      (t tp)))
			 ,ia)))
	  input-map
	  input-args))

(defun get-bind-let (args)
  (remove 'nil 
	   (mapcar #'(lambda (arg &aux 
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
  (let* ((execute-fun-args (mapcar #'(lambda (arg)
				       (if (eql (getf arg :direction) :input)
					   (create-symbol '% (first arg))
					   (first arg)))
				   args))
	 (bind-let (get-bind-let args) )
	 (input-map (get-input-map args))
	 (input-args (get-input-args args))
	 (output-map (get-output-map args))
	 (output-ptrs (mapcar 'first output-map))
	 (alloc-map (append input-map output-map))
	 (export-fun-args (get-export-fun-args (remove 'nil
						       (mapcar #'(lambda (arg)
								   (when (not (getf arg :bind-val))
								     (first arg))) args))
					       output-ptrs)))
    `(progn
       (defun ,export-fun (,@export-fun-args)
	 (let (,@bind-let)
	   (cffi:with-foreign-objects (,@alloc-map)
	     ,@(when input-map
		 (generate-multi-setf input-map input-args))
	     ,(if return-ret
		  `(let ((ret (,execute-fun ,@execute-fun-args)))
		     (values ,(if translate-return
				  `(cffi:mem-ref ret ',(second ret))
				  `ret)
			     ,@ (translate-output-map output-map)))
		  `(progn 
		     (,execute-fun ,@execute-fun-args)
		     (values ,@ (translate-output-map output-map)))))))
       (export ',export-fun))))

(defun gen-cffi-struct-body (body)
  "remove some custom args"
  (mapcar #'(lambda (bd)
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

