(in-package :sdl3)

(defun type-is-struct-p (lst)
  (and (listp (second lst))
       (eql (first (second lst)) :struct)))

(defun get-struct-slots (args)
  (remove nil (mapcar (lambda (arg)
			(when (type-is-struct-p arg)
			  (list (first arg)      ;; name
				(second arg))))  ;; type
		      args)))

(defun gen-map (lst1 lst2 ptrlst ctype)
  (mapcar (lambda (a b)
	    (let ((sptrp (find a ptrlst :key 'first)))
	      (if sptrp
		  `(setf (cffi:mem-ref (cffi:foreign-slot-pointer ptr
								  '(:struct ,ctype)
								  ',a)
				       ',(second sptrp))
			 ,b)
		  `(setf ,a ,b))))
	  lst1 lst2))

(defun gen-key-map (lst1 lst2)
  (apply 'append
	 (mapcar (lambda (a b)
		   (list (alexandria-1:make-keyword a) b))
		 lst1
		 lst2)))

(defun generate-translate-to-foreign (ctype c-type cslots lslots ptrlst)
  (let* ((setfmt (gen-map cslots lslots ptrlst ctype))
	 (ptrslots (mapcar 'first ptrlst))
	 (new-cslots (set-difference cslots ptrslots)))
    `(defmethod cffi:translate-into-foreign-memory (value (type ,c-type) ptr)
       ,(if new-cslots
	    `(cffi:with-foreign-slots (,new-cslots ptr (:struct ,ctype))
	       (with-slots ,lslots value
		 ,@setfmt))
	    `(with-slots ,lslots value
	       ,@setfmt)))))

(defun generate-translate-from-foreign (ctype c-type cslots lslots)
  (let ((keymap (gen-key-map lslots cslots)))
    `(defmethod cffi:translate-from-foreign (ptr (type ,c-type))
       (cffi:with-foreign-slots (,cslots ptr (:struct ,ctype))
	 (make-instance ',ctype ,@keymap)))))

;; (defun generate-expand-to-foreign (ctype c-type cslots lslots)
;;   (let ((setfmt (gen-map cslots lslots)))
;;     `(defmethod cffi:expand-into-foreign-memory (value (type ,c-type) ptr)
;;        (quote (cffi:with-foreign-slots (,cslots ptr (:struct ,ctype))
;; 		(with-slots ,lslots value
;; 		  ,@setfmt))))))

;; (defun generate-expand-from-foreign (ctype c-type cslots lslots)
;;   (let ((keymap (gen-key-map lslots cslots)))
;;     `(defmethod cffi:expand-from-foreign (ptr (type ,c-type))
;;        `(cffi:with-foreign-slots (cslots  ,ptr (:struct ctype))
;; 	  (make-instance ',,ctype ,,@keymap)))))

(defun generate-ptr-slot-funs (name cslots)
  (loop :for slot :in cslots
	:for fun-name := (create-symbol name '-ptr- slot)
	:collect `(eval-when (:load-toplevel :compile-toplevel :execute)
		    (defun ,fun-name (ptr)
		      (cffi:foreign-slot-value ptr '(:struct ,name) ',slot))
		    (defun (setf ,fun-name) (value ptr)
		      (setf (cffi:foreign-slot-value ptr '(:struct ,name) ',slot)
			    value))
		    (export ',fun-name))))

(defmacro deflsp-type (name &body body)
  (let* ((cslots (mapcar #'first body))
	 (lsp-funs (mapcar (lambda (s)
			     "all class function add %"
			     (create-symbol '% s))
			   cslots))
	 (translate-type (create-symbol 'c- name))
	 (ptrslots (get-struct-slots body)))
    `(eval-when (:compile-toplevel :load-toplevel :execute)
       (defclass-std:defclass/std ,name () (,lsp-funs))
       (cffi:defcstruct (,name :class ,translate-type) ,@body)
       ,(generate-translate-to-foreign name translate-type cslots lsp-funs ptrslots)
       ,(generate-translate-from-foreign name translate-type cslots lsp-funs)
       ;; todo expand
       ;; ,(generate-expand-to-foreign name translate-type cslots lsp-funs)
       ;; ,(generate-expand-from-foreign name translate-type cslots lsp-funs)
       ,@(generate-ptr-slot-funs name cslots)
       (export ',name)
       (export ',lsp-funs))))

(defun first-or-identity (thing)
  (if (listp thing)
      (first thing)
      thing))

(defmacro defcenum (name-and-options &body enum-list)
  (let ((name (first-or-identity name-and-options))
        (keywords (mapcar #'first-or-identity enum-list)))
    `(eval-when (:compile-toplevel :load-toplevel :execute)
       (cffi:defcenum ,name-and-options
         ,@enum-list)
       (deftype ,name ()
         `(member ,,@keywords)))))

(defmacro defbitfield (name-and-options &body bitfield-list)
  (let ((name (first-or-identity name-and-options))
        (keywords (mapcar #'first-or-identity bitfield-list)))
    `(eval-when (:compile-toplevel :load-toplevel :execute)
       (cffi:defbitfield ,name-and-options
         ,@bitfield-list)
       (deftype ,name ()
         `(member ,,@keywords)))))
