(in-package :sdl3)


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
    `(defmethod cffi:expand-into-foreign-memory (value (type ,c-type) ptr)
       (quote (cffi:with-foreign-slots (,cslots ptr (:struct ,ctype))
		(with-slots ,lslots value
		  ,@setfmt))))))

(defun generate-expand-from-foreign (ctype c-type cslots lslots)
  (let ((keymap (gen-key-map lslots cslots)))
    `(defmethod cffi:expand-from-foreign (ptr (type ,c-type))
       `(cffi:with-foreign-slots (cslots  ,ptr (:struct ctype))
	  (make-instance ',,ctype ,,@keymap)))))


(defmacro deflsp-type (name &body body)
  (let* ((cslots (mapcar #'first body))
	 (lsp-funs (mapcar (lambda (s)
			     "all class function add %"
			     (create-symbol '% s))
			   cslots))
	 (translate-type (create-symbol 'c- name)))
    `(eval-when (:compile-toplevel :load-toplevel :execute)
       (defclass-std:defclass/std ,name () (,lsp-funs))
       (cffi:defcstruct (,name :class ,translate-type) ,@body)
       ,(generate-translate-to-foreign name translate-type cslots lsp-funs)
       ,(generate-translate-from-foreign name translate-type cslots lsp-funs)
       ;; todo expand
       ;; ,(generate-expand-to-foreign name translate-type cslots lsp-funs)
       ;; ,(generate-expand-from-foreign name translate-type cslots lsp-funs)
       (export ',name)
       (export ',lsp-funs))))

