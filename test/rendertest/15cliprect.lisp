(in-package :sdl3.render.test)

(defconstant +clip-rect-size+ 250)
(defconstant +clip-rect-speed+ 200)
(defparameter *position* (make-instance 'sdl3:fpoint :%x 1.0 :%y 1.0))
(defparameter *direction* (make-instance 'sdl3:fpoint :%x 1.0 :%y 1.0))


(sdl3:def-app-init 15-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example Renderer Clipping Rectangle" "1.0" "com.example.renderer-cliprect")
  (unless (sdl3:init :video)
    (format t "~a~%" (sdl3:get-error))
    (return-from 15-init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer "examples/renderer/cliprect" +window-width+ +window-height+ :resizable)
    (unless rst
      (format t "~a~%" (sdl3:get-error))
      (return-from 15-init :failure))
    (setf *window-handle* window
	  *renderer-handler* renderer)
    (let ((surface (sdl3:load-bmp (%u:load-texture "sample.bmp"))))
      (when (cffi:null-pointer-p surface)
	(format t "~a~%" (sdl3:get-error))
	(return-from 15-init :failure))
      ;; translate surface
      (with-slots ((texture-width sdl3:%w)
		   (texture-height sdl3:%h))
	  (cffi:mem-ref surface '(:struct sdl3:surface))
	(format t "texture width: ~a~%" texture-width)
	(format t "texture height: ~a~%" texture-height)
	(setf *texture-height* (%u:to-single-float texture-height)
	      *texture-width* (%u:to-single-float texture-width)))
      (let ((texture (sdl3:create-texture-from-surface *renderer-handler* surface)))
	(when (cffi:null-pointer-p texture)
	  (format t "~a~%" (sdl3:get-error))
	  (return-from 15-init :failure))
	(setf *texture-handler* texture))
      (sdl3:destroy-surface surface)))
  :continue)

(sdl3:def-app-iterate 15-iterate ()
  (let* ((now (sdl3:get-ticks))
	 (elapsed (%u:to-single-float (/ (- now *last-time*) 1000.0)))
	 (distance (* elapsed +clip-rect-speed+))
	 (cliprect (make-instance 'sdl3:rect
				  :%x (floor (sdl3:%x *position*))
				  :%y (floor (sdl3:%y *position*))
				  :%w +clip-rect-size+
				  :%h +clip-rect-size+)))
    (setf (sdl3:%x *position*) (+ (sdl3:%x *position*)
				  (* distance (sdl3:%x *direction*)))
	  (sdl3:%y *position*) (+ (sdl3:%y *position*)
				  (* distance (sdl3:%y *direction*))))
    (when (< (sdl3:%x *position*) 0.0)
      (setf (sdl3:%x *position*) 0.0
	    (sdl3:%x *direction*) 1.0))
    (when (>= (sdl3:%x *position*) (- +window-width+ +clip-rect-size+))
      (setf (sdl3:%x *position*) (- +window-width+ +clip-rect-size+ 1)
	    (sdl3:%x *direction*) -1.0))

    (when (< (sdl3:%y *position*) 0.0)
      (setf (sdl3:%y *position*) 0.0
	    (sdl3:%y *direction*) 1.0))
    (when (>= (sdl3:%y *position*) (- +window-height+ +clip-rect-size+))
      (setf (sdl3:%y *position*) (- +window-height+ +clip-rect-size+ 1)
	    (sdl3:%y *direction*) -1.0))
    
    (sdl3:set-render-clip-rect *renderer-handler* cliprect)
    
    (setf *last-time* now)
    (sdl3:set-render-draw-color *renderer-handler* 33 33 33 255)
    (sdl3:render-clear *renderer-handler*)
    
    (sdl3:render-texture *renderer-handler* *texture-handler* nil nil)
    
    (sdl3:render-present *renderer-handler*))
  :continue)

(sdl3:def-app-event 15-event (event-type pevent)
  (when (eql event-type :quit)
    (return-from 15-event :success))
  :continue)

(sdl3:def-app-quit 15-quit (result)
  (declare (ignore result))
  (sdl3:destroy-texture *texture-handler*))

(defun do-cliprect-demo ()
  (renderer-init)
  (sdl3:enter-app-main-callbacks '15-init '15-iterate '15-event '15-quit))


