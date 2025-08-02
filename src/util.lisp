(in-package :sdl3)

(defun create-symbol (&rest names)
  (values (intern (format nil "~{~a~}" names))))

(defun string+ (str v)
  (concatenate 'string 
	       (string str) (string v)))
