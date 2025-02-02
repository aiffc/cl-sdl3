(in-package :sdl3.event.test)

(defparameter *window-handle* nil)
(defparameter *renderer-handler* nil)

(sdl3:def-app-init mouse-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example event mouse" "1.0" "com.example.event.mouse")
  (when (not (sdl3:init :video))
    (format t "~a~%" (sdl3:get-error))
    (return-from mouse-init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer "examples/event/mouse" 900 900 :resizable)
    (if (not rst)
	(progn 
	  (format t "~a~%" (sdl3:get-error))
	  (return-from mouse-init :failure))
	(setf *window-handle* window
	      *renderer-handler* renderer)))
  :continue)

(sdl3:def-app-iterate mouse-iterate ()
  (sdl3:set-render-draw-color *renderer-handler* 100 100 100 255)
  (sdl3:render-clear *renderer-handler*)
  (sdl3:render-present *renderer-handler*)
  :continue)

(sdl3:def-app-event mouse-event (event-type pevent)
  (cond ((eql event-type :quit) (return-from mouse-event :success))
	((eql event-type :mouse-button-down)
	 (with-slots (sdl3:%button)
	     (cffi:mem-ref pevent '(:struct sdl3:mouse-button-event))
	   (format t "mouse ~a down~%" sdl3:%button)))
	((eql event-type :mouse-button-up)
	 (with-slots (sdl3:%button)
	     (cffi:mem-ref pevent '(:struct sdl3:mouse-button-event))
	   (format t "mouse ~a up~%" sdl3:%button)))
	((eql event-type :mouse-motion)
	 (with-slots (sdl3:%x
		      sdl3:%y
		      sdl3:%xrel
		      sdl3:%yrel)
	     (cffi:mem-ref pevent '(:struct sdl3:mouse-motion-event))
	   (format t "~a ~a ~a ~a~%" sdl3:%x sdl3:%y sdl3:%xrel sdl3:%yrel)))
	((eql event-type :mouse-wheel)
	 (with-slots (sdl3:%direction
		      sdl3:%x
		      sdl3:%y
		      sdl3:%mouse-x
		      sdl3:%mouse-y)
	     (cffi:mem-ref pevent '(:struct sdl3:mouse-wheel-event))
	   (format t "~a ~a ~a ~a ~a~%" sdl3:%direction sdl3:%x sdl3:%y sdl3:%mouse-x sdl3:%mouse-y))
	 (with-slots (sdl3:%x
		      sdl3:%y
		      sdl3:%xrel
		      sdl3:%yrel)
	     (cffi:mem-ref pevent '(:struct sdl3:mouse-motion-event))
	   (format t "~a ~a ~a ~a~%" sdl3:%x sdl3:%y sdl3:%xrel sdl3:%yrel)))
	((eql event-type :key-down)
	 (with-slots (sdl3:%key
		      sdl3:%scancode
		      sdl3:%mod)
	     (cffi:mem-ref pevent '(:struct sdl3:keyboard-event))
	   (format t "~a down~%" sdl3:%scancode)
	   (when (or (eql sdl3:%scancode :q) (eql sdl3:%scancode :escape))
	     (return-from mouse-event :success)))))
  :continue)

(sdl3:def-app-quit mouse-quit (result)
  (declare (ignore result)))

(defun do-mouse-demo ()
  (sdl3:enter-app-main-callbacks 'mouse-init 'mouse-iterate 'mouse-event 'mouse-quit))

