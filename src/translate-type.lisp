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

(defun generate-translate-to-foreign (ctype type-class slot-names pointer-slots-def)
  `(defmethod cffi:translate-into-foreign-memory (value (type ,type-class) ptr)
     (with-slots ,slot-names value
       ,@(loop for slot in slot-names
               for pointer-slot = (find slot pointer-slots-def :key #'first)
               collect (if pointer-slot
                           `(setf (cffi:mem-ref
                                   (cffi:foreign-slot-pointer ptr '(:struct ,ctype) ',slot)
                                   ',(second pointer-slot))
                                  ,slot)
                           `(setf (cffi:foreign-slot-value ptr '(:struct ,ctype) ',slot)
                                  ,slot))))))

(defun generate-translate-from-foreign (ctype type-class slot-names)
  `(defmethod cffi:translate-from-foreign (ptr (type ,type-class))
     (cffi:with-foreign-slots (,slot-names ptr (:struct ,ctype))
       (make-instance ',ctype ,@(loop for slot in slot-names
                                      collect (alexandria.1.0.0:make-keyword slot)
                                      collect slot)))))

;; (defun generate-expand-to-foreign (ctype c-type cslots lslots)
;;   (let ((setfmt (gen-map cslots lslots)))
;;     `(defmethod cffi:expand-into-foreign-memory (value (type ,c-type) ptr)
;;        (quote (cffi:with-foreign-slots (,cslots ptr (:struct ,ctype))
;;		(with-slots ,lslots value
;;		  ,@setfmt))))))

;; (defun generate-expand-from-foreign (ctype c-type cslots lslots)
;;   (let ((keymap (gen-key-map lslots cslots)))
;;     `(defmethod cffi:expand-from-foreign (ptr (type ,c-type))
;;        `(cffi:with-foreign-slots (cslots  ,ptr (:struct ctype))
;;	  (make-instance ',,ctype ,,@keymap)))))


(defmacro deflsp-type (name &body body)
;; Prefix all slot names with %
  (let* ((body (loop for (slot-name . slot-def) in body
                     collect (cons (create-symbol '% slot-name) slot-def)))
         (slot-names (mapcar #'first body))
         (type-class (create-symbol 'c- name))
         (pointer-slots-def (get-struct-slots body))) ;; slos which are structs
    `(eval-when (:compile-toplevel :load-toplevel :execute)
       (defclass-std:defclass/std ,name () (,slot-names))
       (cffi:defcstruct (,name :class ,type-class)
         ,@(loop for slot in body
                 for name in slot-names
                 collect (cons name (rest slot))))
       ,(generate-translate-to-foreign name type-class slot-names pointer-slots-def)
       ,(generate-translate-from-foreign name type-class slot-names)
       ;; todo expand
       ;; ,(generate-expand-to-foreign name type-class cslots lsp-funs)
       ;; ,(generate-expand-from-foreign name type-class cslots lsp-funs)
       (export ',name)
       (export ',slot-names))))

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

(defun convert-ctype-to-lisp (typespec)
  "Convert CFFI type specifier to lisp one.
This doesn't handle all cases but works fine for our use."
  (cond ((keywordp typespec) ;; basic types
         (ecase typespec
           ((:int :int8 :int16 :int32 :int64) 'integer)
           ((:uint :uint8 :uint16 :uint32 :uint64) 'unsigned-byte)))
        ((eql (first typespec) :struct)
         ;; Since all structs in this library are defined by deflsp-type
         ;; struct have their corresponding lisp type with same name
         (assert (find-class (second typespec)))
         (second typespec))
        (t (error "Can't convert ~a to lisp type" typespec))))

(defmacro defcunion (name-and-options &body union-list)
  (let ((name (first-or-identity name-and-options)))
    `(eval-when (:compile-toplevel :load-toplevel :execute)
       (cffi:defcunion ,name-and-options
         ,@union-list)
       (deftype ,name ()
         '(or ,@(remove-duplicates
                 ;; skip the first field of the union
                 ;; and convert all else to lisp type
                 (loop for spec in (rest union-list)
                       for array-size = (getf (nthcdr 2 spec) :count nil)
                       for lisp-type = (convert-ctype-to-lisp (second spec))
                       when (and lisp-type array-size)
                         collect `(array ,lisp-type (,array-size))
                       when (and lisp-type (not array-size))
                         collect lisp-type)))))))
