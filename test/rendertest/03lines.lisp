(in-package :sdl3.render.test)

(sdl3:def-app-init 03-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example Renderer Lines" "1.0" "Example Renderer Lines")
  (when (not (sdl3:init :video))
    (format t "~a~%" (sdl3:get-error))
    (return-from 03-init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer "examples/renderer/clear" +window-width+ +window-height+ :resizable)
    (if (not rst)
	(progn 
	  (format t "~a~%" (sdl3:get-error))
	  (return-from 03-init :failure))
	(setf *window-handle* window
	      *renderer-handler* renderer)))
  :continue)

(sdl3:def-app-iterate 03-iterate ()
  (sdl3:set-render-draw-color *renderer-handler* 100 100 100 255)
  (sdl3:render-clear *renderer-handler*)

  (sdl3:set-render-draw-color *renderer-handler* 127 49 32 255)
  (sdl3:render-line *renderer-handler* 240.0 450.0 400.0 450.0)
  (sdl3:render-line *renderer-handler* 240.0 356.0 400.0 356.0)
  (sdl3:render-line *renderer-handler* 240.0 356.0 240.0 450.0)
  (sdl3:render-line *renderer-handler* 400.0 356.0 400.0 450.0)

  (sdl3:set-render-draw-color *renderer-handler* 0 255 0 255)
  (sdl3:render-lines *renderer-handler*
		     (make-array 9 :initial-contents
				 (list (make-instance 'sdl3:fpoint
						      :%x 100.0
						      :%y 354.0)
				       (make-instance 'sdl3:fpoint
						      :%x 220.0
						      :%y 230.0)
				       (make-instance 'sdl3:fpoint
						      :%x 140.0
						      :%y 230.0)
				       (make-instance 'sdl3:fpoint
						      :%x 320.0
						      :%y 100.0)
				       (make-instance 'sdl3:fpoint
						      :%x 500.0
						      :%y 230.0)
				       (make-instance 'sdl3:fpoint
						      :%x 420.0
						      :%y 230.0)
				       (make-instance 'sdl3:fpoint
						      :%x 540.0
						      :%y 354.0)
				       (make-instance 'sdl3:fpoint
						      :%x 400.0
						      :%y 354.0)
				       (make-instance 'sdl3:fpoint
						      :%x 100.0
						      :%y 354.0))))
  (loop :for i :from 0 :below 300
	:for size := 30.0
	:for x := 320.0
	:for y := (- 95.0 15.0)
	:for r := (random 255)
	:for g := (random 255)
	:for b := (random 255)
	:do (progn 
	      (sdl3:set-render-draw-color *renderer-handler* r g b 255)
	      (sdl3:render-line *renderer-handler* 
				x y 
				(%u:to-single-float (+ x (* (sin i) size)))
				(%u:to-single-float (+ y (* (cos i) size))))))

  (sdl3:render-present *renderer-handler*)
  :continue)

(sdl3:def-app-event 03-event (type event)
  (declare (ignore type))
  (typecase (sdl3:event-unmarshal event)
    (sdl3:quit-event :success)
    (t :continue)))

(sdl3:def-app-quit 03-quit (result)
  (declare (ignore result))
  (sdl3:destroy-renderer *renderer-handler*)
  (sdl3:destroy-window *window-handle*)
  (sdl3:pump-events)
  (sdl3:quit-sub-system :video)
  (sdl3:quit))

(defun do-lines-demo ()
  (renderer-init)
  (sdl3:enter-app-main-callbacks '03-init '03-iterate '03-event '03-quit))
