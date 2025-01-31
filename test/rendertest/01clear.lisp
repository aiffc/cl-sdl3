(in-package :sdl3.render.test)

(sdl3:def-app-init 01-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example Renderer Clear" "1.0" "com.example.renderer-clear")
  (when (not (sdl3:init :video))
    (format t "~a~%" (sdl3:get-error))
    (return-from 01-init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer "examples/renderer/clear" +window-width+ +window-height+ :resizable)
    (if (not rst)
	(progn 
	  (format t "~a~%" (sdl3:get-error))
	  (return-from 01-init :failure))
	(setf *window-handle* window
	      *renderer-handler* renderer)))
  :continue)

(sdl3:def-app-iterate 01-iterate ()
  (let* ((now (/ (sdl3:get-ticks) 1000.0))
	 (red (%u:to-single-float (+ 0.5 (* (sin now) 0.5))))
	 (green (%u:to-single-float (+ 0.5 (* (sin (+ now
						      (/ (* 2 pi) 3)))
					      0.5))))
	 (blue (%u:to-single-float  (+ 0.5 (* (sin (+ now
						      (/ (* 4 pi) 3)))
					      0.5)))))
    (sdl3:set-render-draw-color-float *renderer-handler* red green blue 1.0)
    (sdl3:render-clear *renderer-handler*)
    (sdl3:render-present *renderer-handler*))
  :continue)

(sdl3:def-app-event 01-event (event-type)
  (when (eql event-type :quit)
    (return-from 01-event :success))
  :continue)

(sdl3:def-app-quit 01-quit (result)
  (declare (ignore result)))

(defun do-clear-demo ()
  (renderer-init)
  (sdl3:enter-app-main-callbacks '01-init '01-iterate '01-event '01-quit))
