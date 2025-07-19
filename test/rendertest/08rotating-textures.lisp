(in-package :sdl3.render.test)

(sdl3:def-app-init 08-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example Renderer Rotating Textures" "1.0" "com.example.renderer-rotating-textures")
  (unless (sdl3:init :video)
    (format t "~a~%" (sdl3:get-error))
    (return-from 08-init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer "examples/renderer/rotating-textures" +window-width+ +window-height+ :resizable)
    (unless rst
      (format t "~a~%" (sdl3:get-error))
      (return-from 08-init :failure))
    (setf *window-handle* window
	  *renderer-handler* renderer)
    (let ((surface (sdl3:load-bmp (%u:load-texture "sample.bmp"))))
      (when (cffi:null-pointer-p surface)
	(format t "~a~%" (sdl3:get-error))
	(return-from 08-init :failure))
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
	  (return-from 08-init :failure))
	(setf *texture-handler* texture))
      (sdl3:destroy-surface surface)))
  :continue)

(sdl3:def-app-iterate 08-iterate ()
  (let* ((now (sdl3:get-ticks))
	 (rotation (%u:to-single-float (* (/ (mod now 2000) 2000.0)
					  360.0)))
	 (center (make-instance 'sdl3:fpoint :%x (/ *texture-width* 2.0)
					     :%y (/ *texture-height* 2.0)))
	 (dst-rect (make-instance 'sdl3:frect 
				  :%x (/ (- +window-width+ *texture-width*) 2.0)
				  :%y (/ (- +window-height+ *texture-height*) 2.0)
				  :%w *texture-width*
				  :%h *texture-height*)))
    (sdl3:set-render-draw-color *renderer-handler* 0 0 0 255)
    (sdl3:render-clear *renderer-handler*)
    (sdl3:render-texture-rotated *renderer-handler*
				 *texture-handler*
				 nil
				 dst-rect
				 (coerce rotation 'double-float)
				 center
				 :none)
    (sdl3:render-present *renderer-handler*))
  :continue)

(sdl3:def-app-event 08-event (type event)
  (declare (ignore type))
  (typecase (sdl3:event-unmarshal event)
    (sdl3:quit-event :success)
    (t :continue)))

(sdl3:def-app-quit 08-quit (result)
  (declare (ignore result))
  (sdl3:destroy-texture *texture-handler*)
  (sdl3:destroy-renderer *renderer-handler*)
  (sdl3:destroy-window *window-handle*)
  (sdl3:pump-events)
  (sdl3:quit-sub-system :video)
  (sdl3:quit))

(defun do-rotating-texture-demo ()
  (renderer-init)
  (sdl3:enter-app-main-callbacks '08-init '08-iterate '08-event '08-quit))


