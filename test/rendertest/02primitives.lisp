(in-package :sdl3.render.test)

(defparameter *02pointes* (make-array 500
				    :initial-contents
				    (loop :repeat 500
					  :collect (make-instance
						    'sdl3:fpoint 
						    :%y (+ 100.0 (* 280.0 (random 1.0)))
						    :%x (+ 100.0 (* 440.0 (random 1.0)))))))

(sdl3:def-app-init 02-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example Renderer Primitives" "1.0" "Example Renderer Clear")
  (when (not (sdl3:init :video))
    (format t "~a~%" (sdl3:get-error))
    (return-from 02-init :failure))
  
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer "com.example.renderer-clear" +window-width+ +window-height+ :resizable)
    (if (not rst)
	(progn 
	  (format t "~a~%" (sdl3:get-error))
	  (return-from 02-init :failure))
	(setf *window-handle* window
	      *renderer-handler* renderer)))
  :continue)

(sdl3:def-app-iterate 02-iterate ()
  (sdl3:set-render-draw-color *renderer-handler* 33 33 33 255)
  (sdl3:render-clear *renderer-handler*)

  (sdl3:set-render-draw-color *renderer-handler* 0 0 255 255)
  (sdl3:render-fill-rect *renderer-handler* (make-instance 'sdl3:rect
							   :%x 100.0
							   :%y 100.0
							   :%w 440.0
							   :%h 280.0))
  
  (sdl3:set-render-draw-color *renderer-handler* 0 255 255 255)
  (sdl3:render-rect *renderer-handler* (make-instance 'sdl3:rect
						      :%x 130.0
						      :%y 130.0
						      :%w 380.0
						      :%h 220.0))

  (sdl3:set-render-draw-color *renderer-handler* 255 255 0 255)
  (sdl3:render-line *renderer-handler* 0.0 0.0 640.0 480.0)
  (sdl3:render-line *renderer-handler* 0.0 480.0 640.0 0.0)
  
  (sdl3:set-render-draw-color *renderer-handler* 255 0 0 255)
  (sdl3:render-points *renderer-handler* *02pointes*)
  (sdl3:render-present *renderer-handler*)

  :continue)

(sdl3:def-app-event 02-event (type event)
  (declare (ignore type))
  (typecase (sdl3:event-unmarshal event)
    (sdl3:quit-event :success)
    (t :continue)))

(sdl3:def-app-quit 02-quit (result)
  (declare (ignore result))
  (sdl3:destroy-renderer *renderer-handler*)
  (sdl3:destroy-window *window-handle*)
  (sdl3:pump-events)
  (sdl3:quit-sub-system :video)
  (sdl3:quit))

(defun do-primitives-demo ()
  (renderer-init)
  (sdl3:enter-app-main-callbacks '02-init '02-iterate '02-event '02-quit))
