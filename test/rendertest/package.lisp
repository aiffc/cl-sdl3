(defpackage :sdl3.render.test
  (:use #:cl))

(in-package :sdl3.render.test)

(defparameter *window-handle* nil)
(defparameter *renderer-handler* nil)
(defparameter *texture-handler* nil)
(defparameter *texture-width* 0)
(defparameter *texture-height* 0)
(defparameter *last-time* 0)

(defconstant +window-width+ 640)
(defconstant +window-height+ 480)

(defun renderer-init ()
  (setf *window-handle* nil
	*renderer-handler* nil
	*texture-handler* nil
	*texture-width* 0
	*texture-height* 0
	*last-time* 0))
