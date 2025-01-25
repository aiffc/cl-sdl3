(in-package :sdl3.render.test)

(defparameter *window-handle* nil)
(defparameter *renderer-handler* nil)

(sdl3:def-app-init init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example Renderer Clear" "1.0" "com.example.renderer-clear")
  (when (not (sdl3:init :video))
    (format t "~a~%" (sdl3:get-error))
    (return-from init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer "examples/renderer/clear" 400 400 :resizable)
    (if (not rst)
	(progn 
	  (format t "~a~%" (sdl3:get-error))
	  (return-from init :failure))
	(setf *window-handle* window
	      *renderer-handler* renderer)))
  :continue)

(sdl3:def-app-iterate iterate ()
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

(sdl3:def-app-event event (event-type)
  (when (eql event-type :quit)
    (return-from event :success))
  :continue)

(sdl3:def-app-quit quit (result)
  (declare (ignore result)))

(defun do-clear-demo ()
  (setf *window-handle* nil
	*renderer-handler* nil)
  (sdl3:enter-app-main-callbacks 'init 'iterate 'event 'quit))
