(in-package :sdl3)

(cffi:defctype size-t #. (if (= 4 (cffi:foreign-type-size :pointer)) :uint32 :uint64))

(defun create-symbol (&rest names)
  (values (intern (format nil "~{~a~}" names))))

(defun string+ (str v)
  (concatenate 'string 
	       (string str) (string v)))
