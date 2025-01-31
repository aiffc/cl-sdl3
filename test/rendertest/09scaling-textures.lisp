(in-package :sdl3.render.test)

(sdl3:def-app-init 09-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example Renderer Scaling Textures" "1.0" "com.example.renderer-scaling-textures")
  (unless (sdl3:init :video)
    (format t "~a~%" (sdl3:get-error))
    (return-from 09-init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer "examples/renderer/scaling-textures" +window-width+ +window-height+ :resizable)
    (unless rst
      (format t "~a~%" (sdl3:get-error))
      (return-from 09-init :failure))
    (setf *window-handle* window
	  *renderer-handler* renderer)
    (let ((surface (sdl3:load-bmp (%u:load-texture "sample.bmp"))))
      (when (cffi:null-pointer-p surface)
	(format t "~a~%" (sdl3:get-error))
	(return-from 09-init :failure))
      ;; translate surface
      (with-slots ((texture-width sdl3:%w)
		   (texture-height sdl3:%h))
	  (cffi:mem-ref surface '(:struct sdl3:surface))
	(format t "texture width: ~a~%" texture-width)
	(format t "texture height: ~a~%" texture-height)
	(setf *texture-height* (%u:to-single-float texture-height)
	      *texture-width* (%u:to-single-float texture-width)))
      (let ((texture (sdl3:create-texture-from-surface *renderer-handler* surface)))
	(when (cffi:null-pointer-p texture)
	  (format t "~a~%" (sdl3:get-error))
	  (return-from 09-init :failure))
	(setf *texture-handler* texture))
      (sdl3:destroy-surface surface)))
  :continue)

(sdl3:def-app-iterate 09-iterate ()
  (let* ((now (sdl3:get-ticks))
	 (direction (if (>= (mod now 2000) 1000) 1.0 -1.0))
	 (scale (%u:to-single-float (* (/ (- (mod now 1000) 500) 500.0) direction)))
	 (dst-rect (make-instance 'sdl3:frect 
				  :%x (/ (- +window-width+ 
					    (+ *texture-width* (* *texture-width* scale)))
					 2.0 )
				  :%y (/ (- +window-height+
					    (+ *texture-height* (* *texture-height* scale)))
					 2.0 )
				  :%w (+ *texture-width* (* *texture-width* scale))
				  :%h (+ *texture-height* (* *texture-height* scale)))))
    (sdl3:set-render-draw-color *renderer-handler* 0 0 0 255)
    (sdl3:render-clear *renderer-handler*)
    (sdl3:render-texture *renderer-handler*
			 *texture-handler*
			 nil
			 dst-rect)
    (sdl3:render-present *renderer-handler*))
  :continue)

(sdl3:def-app-event 09-event (event-type)
  (when (eql event-type :quit)
    (return-from 09-event :success))
  :continue)

(sdl3:def-app-quit 09-quit (result)
  (declare (ignore result))
  (sdl3:destroy-texture *texture-handler*))

(defun do-scaling-texture-demo ()
  (renderer-init)
  (sdl3:enter-app-main-callbacks '09-init '09-iterate '09-event '09-quit))


