(in-package :sdl3.render.test)

(defconstant +num-points+ 500)
(defconstant +min-pixels-per-second+ 30)
(defconstant +max-pixels-per-second+ 60)

(defparameter *04-points* (make-array +num-points+
				   :initial-contents
				   (loop :repeat +num-points+
					 :collect (make-instance 'sdl3:fpoint
								 :%x (%u:to-single-float (* +window-width+ (random 1.0)))
								 :%y (%u:to-single-float (* +window-height+ (random 1.0)))))))

(defparameter *04-point-speeds* (make-array +num-points+ 
					 :initial-contents
					 (loop :repeat +num-points+
					       :collect (%u:to-single-float
							 (+ +min-pixels-per-second+
							    (* (random 1.0) 
							       (- +max-pixels-per-second+
								  +min-pixels-per-second+)))))))

(sdl3:def-app-init 04-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example Renderer Points" "1.0" "com.example.renderer-points")
  (when (not (sdl3:init :video))
    (format t "~a~%" (sdl3:get-error))
    (return-from 04-init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer "examples/renderer/points" +window-width+ +window-height+ :resizable)
    (if (not rst)
	(progn 
	  (format t "~a~%" (sdl3:get-error))
	  (return-from 04-init :failure))
	(setf *window-handle* window
	      *renderer-handler* renderer)))
  :continue)

(sdl3:def-app-iterate 04-iterate ()
  (let* ((now (sdl3:get-ticks))
	 (elapsed (/ (- now *last-time*)
		     1000.0)))
    (loop :for i :from 0 :below +num-points+
	  :for distance := (* elapsed (elt *04-point-speeds* i))
	  :for pos := (elt *04-points* i)
	  :for x := (sdl3:%x pos)
	  :for y := (sdl3:%y pos)
	  :for new-x := (+ x distance)
	  :for new-y := (+ y distance)
	  :do (progn 
		(setf (elt *04-points* i)
		      (make-instance 'sdl3:fpoint
				     :%x (%u:to-single-float new-x)
				     :%y (%u:to-single-float new-y)))
		(when (or (> new-x +window-width+)
			  (> new-y +window-height+))
		  (if (= 0 (random 2))
		      (setf (aref *04-points* i)
			    (make-instance 'sdl3:fpoint
					   :%x 0.0
					   :%y (%u:to-single-float
						(* (random 1.0)
						   +window-height+))))
		      (setf (aref *04-points* i)
			    (make-instance 'sdl3:fpoint
					   :%x (%u:to-single-float 
						(* (random 1.0)
						   +window-width+))
					   :%y 0.0))))
		(setf *last-time* now)))
    (sdl3:set-render-draw-color *renderer-handler* 0 0 0 255)
    (sdl3:render-clear *renderer-handler*)
    (sdl3:set-render-draw-color *renderer-handler* 255 255 255 255)
    (sdl3:render-points *renderer-handler* *04-points*)
    (sdl3:render-present *renderer-handler*))
  :continue)

(sdl3:def-app-event 04-event (type event)
  (declare (ignore type))
  (typecase (sdl3:event-unmarshal event)
    (sdl3:quit-event :success)
    (t :continue)))

(sdl3:def-app-quit 04-quit (result)
  (declare (ignore result))
  (sdl3:destroy-renderer *renderer-handler*)
  (sdl3:destroy-window *window-handle*)
  (sdl3:pump-events)
  (sdl3:quit-sub-system :video)
  (sdl3:quit))

(defun do-points-demo ()
  (renderer-init)
  (sdl3:enter-app-main-callbacks '04-init '04-iterate '04-event '04-quit))
