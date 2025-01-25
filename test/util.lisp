(defpackage :util
  (:use #:cl)
  (:nicknames :%u)
  (:export #:to-single-float))

(in-package :util)

(defun to-single-float (x)
  (coerce x 'single-float))
