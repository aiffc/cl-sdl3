(defpackage :sdl3.render.test
  (:use #:cl))

(in-package :sdl3.render.test)

(defparameter *window-handle* nil)
(defparameter *renderer-handler* nil)
(defparameter *texture-handler* nil)
(defconstant +window-width+ 640)
(defconstant +window-height+ 480)
