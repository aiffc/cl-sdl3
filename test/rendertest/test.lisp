(in-package :sdl3.render.test)

(defparameter *window-handle* nil)
(defparameter *renderer-handler* nil)

(sdl3:def-app-init init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "basic test" "1.0" "render clear")
  (when (not (sdl3:init :video))
    (format t "~a~%" (sdl3:get-error))
    (return-from init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer "clear window" 400 400 :resizable)
    (if (not rst)
	(progn 
	  (format t "~a~%" (sdl3:get-error))
	  (return-from init :failure))
	(setf *window-handle* window
	      *renderer-handler* renderer)))
  :continue)

(sdl3:def-app-iterate iterate ()
  (sdl3:set-render-draw-color-float *renderer-handler* 1.0 0.5 0.5 1.0)
  (sdl3:render-clear *renderer-handler*)
  (sdl3:render-present *renderer-handler*)
  :continue)

(sdl3:def-app-event event (event-type)
  (when (eql event-type :quit)
    (return-from event :success))
  :continue)

(sdl3:def-app-quit quit (result)
  (declare (ignore result)))

(defun runtest ()
  (setf *window-handle* nil
	*renderer-handler* nil)
  (sdl3:enter-app-main-callbacks 'init 'iterate 'event 'quit))

