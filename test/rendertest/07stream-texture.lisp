(in-package :sdl3.render.test)

(defconstant +texture-size+ 150)
(defparameter *texture-width* 0)
(defparameter *texture-height* 0)

(sdl3:def-app-init 07-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example Renderer Streaming Textures" "1.0" "com.example.renderer-streaming-textures")
  (unless (sdl3:init :video)
    (format t "~a~%" (sdl3:get-error))
    (return-from 07-init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer "examples/renderer/streaming-textures" +window-width+ +window-height+ :resizable)
    (unless rst
      (format t "~a~%" (sdl3:get-error))
      (return-from 07-init :failure))
    (setf *window-handle* window
	  *renderer-handler* renderer
	  *texture-handler* (sdl3:create-texture renderer
						 :rgba8888
						 :streaming
						 +texture-size+
						 +texture-size+)))
  (when (cffi:null-pointer-p *texture-handler*)
    (format t "~a~%" (sdl3:get-error))
    (return-from 07-init :failure))
  :continue)

(sdl3:def-app-iterate 07-iterate ()
  (let* ((now (sdl3:get-ticks))
	 (direction (if (>= (mod now 2000) 1000) 1.0 -1.0))
	 (scale (%u:to-single-float (* (/ (- (mod now 1000) 500) 500.0) direction)))
	 (dst-rect (make-instance 'sdl3:frect 
				  :%x (/ (- +window-width+ +texture-size+) 2.0)
				  :%y (/ (- +window-height+ +texture-size+) 2.0)
				  :%w (%u:to-single-float +texture-size+)
				  :%h (%u:to-single-float +texture-size+)))
	 (rectm (make-instance 'sdl3:rect 
			       :%x 0
			       :%y (floor 
				    (* (- +texture-size+ 
					  (%u:to-single-float (/ +texture-size+ 10)))
				       (/ (+ scale 1.0) 2.0)))
			       :%w +texture-size+
			       :%h (floor (/ +texture-size+ 10)))))
    (multiple-value-bind (rst surface) (sdl3:lock-texture-to-surface *texture-handler* nil)
      (if (and rst (not (cffi:null-pointer-p surface)))
	  (progn 
	    (with-slots ((fmt sdl3:%format))
		(cffi:mem-ref surface '(:struct sdl3:surface))
	      (sdl3:fill-surface-rect surface nil (sdl3:map-rgb (sdl3:get-pixel-format-details fmt) nil 0 0 0))
	      (sdl3:fill-surface-rect surface rectm (sdl3:map-rgb (sdl3:get-pixel-format-details fmt) nil 0 255 0))
	      (sdl3:unlock-texture *texture-handler*)))
	  (progn
	    (format t "~a~%" (sdl3:get-error))
	    (return-from 07-iterate :failure))))
    (sdl3:set-render-draw-color *renderer-handler* 66 66 66 255)
    (sdl3:render-clear *renderer-handler*)
    
    (sdl3:render-texture *renderer-handler* *texture-handler* nil dst-rect)
    (sdl3:render-present *renderer-handler*))
  
  :continue)

(sdl3:def-app-event 07-event (event-type)
  (when (eql event-type :quit)
    (return-from 07-event :success))
  :continue)

(sdl3:def-app-quit 07-quit (result)
  (declare (ignore result))
  (sdl3:destroy-texture *texture-handler*))

(defun do-stream-texture-demo ()
  (setf *window-handle* nil
	*renderer-handler* nil
	*texture-handler* nil)
  (sdl3:enter-app-main-callbacks '07-init '07-iterate '07-event '07-quit))
