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

(sdl3:def-app-event mouse-event (type event)
  (let ((event-unmarshal (sdl3:event-unmarshal event)))
    (typecase event-unmarshal
      (sdl3:quit-event :success)
      (sdl3:mouse-button-event 
       (let ((button (slot-value event-unmarshal 'sdl3:%button)))
	 (format t "type ~a button ~a~%" type button))
       :continue)
      (sdl3:mouse-motion-event
       (let ((x (slot-value event-unmarshal 'sdl3:%x))
	     (y (slot-value event-unmarshal 'sdl3:%y))
	     (xrel (slot-value event-unmarshal 'sdl3:%xrel))
	     (yrel (slot-value event-unmarshal 'sdl3:%yrel)))
	 (format t "type ~a ~a y ~a xrel ~a yrel ~a~%" type x y xrel yrel))
       :continue)
      (sdl3:mouse-wheel-event 
       (let ((x (slot-value event-unmarshal 'sdl3:%x))
	     (y (slot-value event-unmarshal 'sdl3:%y))
	     (mx (slot-value event-unmarshal 'sdl3:%mouse-x))
	     (my (slot-value event-unmarshal 'sdl3:%mouse-y))
	     (direction (slot-value event-unmarshal 'sdl3:%direction)))
	 (format t "type ~a ~a y ~a xrel ~a yrel ~a direction ~a~%" type x y mx my direction))
       :continue)
      (t :continue))))

(sdl3:def-app-quit mouse-quit (result)
  (declare (ignore result))
  (sdl3:destroy-renderer *renderer-handler*)
  (sdl3:destroy-window *window-handle*)
  (sdl3:pump-events)
  (sdl3:quit-sub-system :video)
  (sdl3:quit))

(defun do-mouse-demo ()
  (sdl3:enter-app-main-callbacks 'mouse-init 'mouse-iterate 'mouse-event 'mouse-quit))

