(in-package :sdl3.event.test)

(defparameter *window-handle* nil)
(defparameter *renderer-handler* nil)

(sdl3:def-app-init keyboard-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example event keyboard" "1.0" "com.example.event.keyboard")
  (when (not (sdl3:init :video))
    (format t "~a~%" (sdl3:get-error))
    (return-from keyboard-init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer "examples/event/keyboard" 100 100 :resizable)
    (if (not rst)
	(progn 
	  (format t "~a~%" (sdl3:get-error))
	  (return-from keyboard-init :failure))
	(setf *window-handle* window
	      *renderer-handler* renderer)))
  :continue)

(sdl3:def-app-iterate keyboard-iterate ()
  :continue)

(sdl3:def-app-event keyboard-event (event-type pevent)
  (cond ((eql event-type :quit) (return-from keyboard-event :success))
	((eql event-type :key-down)
	 (with-slots (sdl3:%key
		      sdl3:%scancode
		      sdl3:%mod)
	     (cffi:mem-ref pevent '(:struct sdl3:keyboard-event))
	   (format t "~a ~a ~a~%" sdl3:%key sdl3:%scancode sdl3:%mod)
	   (when (or (eql sdl3:%scancode :q) (eql sdl3:%scancode :escape))
	     (return-from keyboard-event :success)))))
  :continue)

(sdl3:def-app-quit keyboard-quit (result)
  (declare (ignore result)))

(defun do-keyboard-demo ()
  (sdl3:enter-app-main-callbacks 'keyboard-init 'keyboard-iterate 'keyboard-event 'keyboard-quit))

