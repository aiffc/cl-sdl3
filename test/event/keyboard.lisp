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

(sdl3:def-app-event keyboard-event (type event)
  (let ((event-unmarshal (sdl3:event-unmarshal event)))
    (typecase event-unmarshal
      (sdl3:quit-event :success)
      (sdl3:keyboard-event
       (let ((key (slot-value event-unmarshal 'sdl3:%key))
	     (scancode (slot-value event-unmarshal 'sdl3:%scancode)))
	 (format t "type ~a key ~a scancode ~a~%" type key scancode))
       :continue)
      (t :continue))))

(sdl3:def-app-quit keyboard-quit (result)
  (declare (ignore result)))

(defun do-keyboard-demo ()
  (sdl3:enter-app-main-callbacks 'keyboard-init 'keyboard-iterate 'keyboard-event 'keyboard-quit))

