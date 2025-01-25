(in-package :sdl3)

(cffi:defctype size-t #. (if (= 4 (cffi:foreign-type-size :pointer)) :uint32 :uint64))

(defun create-symbol (&rest names)
  (values (intern (format nil "~{~a~}" names))))

(defun string+ (str v)
  (concatenate 'string 
	       (string str) (string v)))

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
  (if (listp name)
      `(progn 
	 (format t "generate function ~a.~%" (second ',name))
	 (cffi:defcfun ,name ,ret
	   ,@body)
	 (export ',(second name)))
      (let ((lsym (create-symbol (read-from-string (sdl->lsp name)))))
	`(progn 
	   (format t "auto generate function ~a.~%" ',lsym)
	   (cffi:defcfun (,name ,lsym) ,ret
	     ,@body)
	   (export ',lsym)))))

(defmacro defwrap-fun (name ret &body body)
  (if (listp name)
      `(progn 
	 (format t "generate wrap function ~a.~%" (second ',name))
	 (cffi:defcfun ,name ,ret
	   ,@body))
      (let ((lsym (create-symbol '% (read-from-string (sdl->lsp name)))))
	`(progn 
	   (format t "auto wrap generate function ~a.~%" ',lsym)
	   (cffi:defcfun (,name ,lsym) ,ret
	     ,@body)))))
