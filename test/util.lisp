(defpackage :util
  (:use #:cl)
  (:nicknames :%u)
  (:export
   #:to-single-float
   #:load-texture))

(in-package :util)

(defun to-single-float (x)
  (coerce x 'single-float))

(defun load-texture (name)
  (concatenate 'string 
	       (namestring (asdf:system-relative-pathname :sdl3/tests "test/res/"))
	       name))
