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

(defmacro defwrap-fun (name ret &body body)
  (if (listp name)
      `(eval-when (:compile-toplevel :load-toplevel :execute) 
	 (format t "generate wrap function ~a.~%" (second ',name))
	 (cffi:defcfun ,name ,ret
	   ,@body))
      (let ((lsym (create-symbol '% (read-from-string (sdl->lsp name)))))
	`(eval-when (:compile-toplevel :load-toplevel :execute) 
	   (format t "auto generate wrap function ~a.~%" ',lsym)
	   (cffi:defcfun (,name ,lsym) ,ret
	     ,@body)))))


(defun gen-map (lst1 lst2)
  (mapcar (lambda (a b)
	    (list 'setf a b))
	  lst1 lst2))

(defun gen-key-map (lst1 lst2)
  (apply 'append
	 (mapcar (lambda (a b)
		   (list (alexandria-1:make-keyword a) b))
		 lst1
		 lst2)))

(defun generate-translate-to-foreign (ctype c-type cslots lslots)
  (let ((setfmt (gen-map cslots lslots)))
    `(defmethod cffi:translate-into-foreign-memory (value (type ,c-type) ptr)
       (cffi:with-foreign-slots (,cslots ptr (:struct ,ctype))
	 (with-slots ,lslots value
	   ,@setfmt)))))

(defun generate-translate-from-foreign (ctype c-type cslots lslots)
  (let ((keymap (gen-key-map lslots cslots)))
    `(defmethod cffi:translate-from-foreign (ptr (type ,c-type))
       (cffi:with-foreign-slots (,cslots ptr (:struct ,ctype))
	 (make-instance ',ctype ,@keymap)))))

(defun generate-expand-to-foreign (ctype c-type cslots lslots)
  (let ((setfmt (gen-map cslots lslots)))
    `(defmethod cffi:translate-into-foreign-memory (value (type ,c-type) ptr)
       (quote (cffi:with-foreign-slots (,cslots ptr (:struct ,ctype))
		(with-slots ,lslots value
		  ,@setfmt))))))

(defun generate-expand-from-foreign (ctype c-type cslots lslots)
  (let ((keymap (gen-key-map lslots cslots)))
    `(defmethod cffi:translate-from-foreign (ptr (type ,c-type))
       (quote (cffi:with-foreign-slots (,cslots ptr (:struct ,ctype))
		(make-instance ',ctype ,@keymap))))))


(defmacro deflsp-type (name &body body)
  (let* ((cslots (mapcar #'first body))
	 (lsp-funs (mapcar (lambda (s)
			     "all class function add %"
			     (create-symbol '% s))
			   cslots))
	 (translate-type (create-symbol 'c- name)))
    `(eval-when (:compile-toplevel :load-toplevel :execute)
       (format t "~a ~a~%" ',name ',lsp-funs)
       (defclass-std:defclass/std ,name () (,lsp-funs))
       (cffi:defcstruct (,name :class ,translate-type) ,@body)
       ,(generate-translate-to-foreign name translate-type cslots lsp-funs)
       ,(generate-translate-from-foreign name translate-type cslots lsp-funs)
       ,(generate-expand-to-foreign name translate-type cslots lsp-funs)
       ,(generate-expand-from-foreign name translate-type cslots lsp-funs)
       (export ',name)
       (export ',lsp-funs))))
