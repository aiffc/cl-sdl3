(in-package :sdl3.render.test)

(sdl3:def-app-init 05-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example Renderer Rectangles" "1.0" "com.example.renderer-rectangles")
  (when (not (sdl3:init :video))
    (format t "~a~%" (sdl3:get-error))
    (return-from 05-init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer "examples/renderer/rectangles" +window-width+ +window-height+ :resizable)
    (if (not rst)
	(progn 
	  (format t "~a~%" (sdl3:get-error))
	  (return-from 05-init :failure))
	(setf *window-handle* window
	      *renderer-handler* renderer)))
  :continue)

(sdl3:def-app-iterate 05-iterate ()
  (let* ((now (sdl3:get-ticks))
	 (direction (if (>= (mod now 2000) 1000) 1.0 -1.0))
	 (scale (%u:to-single-float (* (/ (- (mod now 1000) 500) 500.0) direction)))
	 (rect0 (make-instance 'sdl3:frect :%x 100.0
					   :%y 100.0
					   :%w (+ 100 (* 100 scale))
					   :%h (+ 100 (* 100 scale))))
	 (rect1-3 (make-array 3 :initial-contents
			      (loop :for i :from 0 :below 3
				    :for size := (* 50.0 (+ i 1))
				    :for w := (+ size (* size scale))
				    :collect (make-instance 'sdl3:frect
							    :%x (/ (- +window-width+ w) 2)
							    :%y (/ (- +window-height+ w) 2)
							    :%w w
							    :%h w))))
	 (rect4 (make-instance 'sdl3:frect :%x 400.0
					   :%y 50.0
					   :%w (+ 100.0 (* 100.0 scale))
					   :%h (+ 50.0 (* 50.0 scale))))
	 (rest-rect (make-array 16 :initial-contents
				(loop :for i :from 0 :below 16
				      :for w := (%u:to-single-float (/ +window-width+ 16))
				      :for h := (%u:to-single-float (* i 8.0))
				      :collect (make-instance 'sdl3:frect
							      :%x (%u:to-single-float (* i w))
							      :%y (%u:to-single-float (- +window-height+ h))
							      :%w w
							      :%h h)))))
    (sdl3:set-render-draw-color *renderer-handler* 0 0 0 255)
    (sdl3:render-clear *renderer-handler*)

    (Sdl3:set-render-draw-color *renderer-handler* 255 0 0 255)
    (sdl3:render-rect *renderer-handler* rect0)

    (sdl3:set-render-draw-color *renderer-handler* 0 255 0 255)
    (sdl3:render-rects *renderer-handler* rect1-3)

    (sdl3:set-render-draw-color *renderer-handler* 0 0 255 255)
    (sdl3:render-fill-rect *renderer-handler* rect4)
    
    (sdl3:set-render-draw-color *renderer-handler* 255 255 255 255)
    (sdl3:render-fill-rects *renderer-handler* rest-rect)
    (sdl3:render-present *renderer-handler*))
  :continue)

(sdl3:def-app-event 05-event (type event)
  (declare (ignore type))
  (typecase (sdl3:event-unmarshal event)
    (sdl3:quit-event :success)
    (t :continue)))

(sdl3:def-app-quit 05-quit (result)
  (declare (ignore result))
  (sdl3:destroy-renderer *renderer-handler*)
  (sdl3:destroy-window *window-handle*)
  (sdl3:pump-events)
  (sdl3:quit-sub-system :video)
  (sdl3:quit))

(defun do-rectangles-demo ()
  (renderer-init)
  (sdl3:enter-app-main-callbacks '05-init '05-iterate '05-event '05-quit))
