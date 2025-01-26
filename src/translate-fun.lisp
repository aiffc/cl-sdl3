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

(defmacro defexport-fun (name ret &body body)
  "function define use this just can use outside"
  (if (listp name)
      `(eval-when (:compile-toplevel :load-toplevel :execute) 
	 (format t "generate function ~a.~%" (second ',name))
	 (cffi:defcfun ,name ,ret
	   ,@body)
	 (export ',(second name)))
      (let ((lsym (create-symbol (read-from-string (sdl->lsp name)))))
	`(eval-when (:compile-toplevel :load-toplevel :execute) 
	   (format t "auto generate function ~a.~%" ',lsym)
	   (cffi:defcfun (,name ,lsym) ,ret
	     ,@body)
	   (export ',lsym)))))


(defun gen-render-multi-fun (name fun-name ctype)
  "auto warp function with a handle and input array"
  `(progn 
     (defun ,name (renderer vals &aux (count (length vals)))
       (cffi:with-foreign-object (ptr '(:struct ,ctype) count)
	 (dotimes (i count)
	   (setf (cffi:mem-aref ptr '(:struct ,ctype) i)
		 (elt vals i)))
	 (,fun-name renderer ptr count)))
     (export ',name)))

(defun gen-render-single-fun (name fun-name ctype)
  "auto warp function with a handle and a input pointer"
  `(progn
     (defun ,name (renderer val)
       (cffi:with-foreign-object (ptr '(:struct ,ctype))
	 (setf (cffi:mem-ref ptr '(:struct ,ctype)) val)
	 (,fun-name renderer ptr)))
     (export ',name)))

(defun do-translate (export-fun execute-fun ctype 
		     &optional (translate-type :render-multi))
  (cond ((eql translate-type :render-multi)
	 (gen-render-multi-fun export-fun execute-fun ctype))
	((eql translate-type :render-single)
	 (gen-render-single-fun export-fun execute-fun ctype))))

(defmacro defwrap-fun (name ret (&optional (translate nil) (ctype nil)) &body body)
  "function define use this, this function need wrap, the translate indiced the function auto translate"
  (if (listp name)
      (let* ((lsp-fun (second name))
	    (%lsp-fun (create-symbol '% lsp-fun)))
	`(eval-when (:compile-toplevel :load-toplevel :execute) 
	   (format t "generate wrap function ~a.~%" %lsp-fun)
	   (cffi:defcfun (,(first name) ,%lsp-fun) ,ret
	     ,@body)
	   ,(when translate (do-translate lsp-fun %lsp-fun ctype translate))))
      (let* ((lsp-fun (read-from-string (sdl->lsp name))) ;; export lsp-fun
	     (%lsp-fun (create-symbol '% lsp-fun)))
	`(eval-when (:compile-toplevel :load-toplevel :execute) 
	   (format t "auto generate wrap function ~a.~%" ',lsp-fun)
	   (cffi:defcfun (,name ,%lsp-fun) ,ret
	     ,@body)
	   ,(when translate (do-translate lsp-fun %lsp-fun ctype translate))))))

