(in-package :sdl3.render.test)

(sdl3:def-app-init 11-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example Renderer Color Mods" "1.0" "com.example.renderer-color-mods")
  (unless (sdl3:init :video)
    (format t "~a~%" (sdl3:get-error))
    (return-from 11-init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer "examples/renderer/color-mods" +window-width+ +window-height+ :resizable)
    (unless rst
      (format t "~a~%" (sdl3:get-error))
      (return-from 11-init :failure))
    (setf *window-handle* window
	  *renderer-handler* renderer)
    (let ((surface (sdl3:load-bmp (%u:load-texture "sample.bmp"))))
      (when (cffi:null-pointer-p surface)
	(format t "~a~%" (sdl3:get-error))
	(return-from 11-init :failure))
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
	  (return-from 11-init :failure))
	(setf *texture-handler* texture))
      (sdl3:destroy-surface surface)))
  :continue)

(sdl3:def-app-iterate 11-iterate ()
  (let* ((now (/ (sdl3:get-ticks) 1000.0))
	 (red (%u:to-single-float (+ 0.5 (* 0.5 (sin now)))))
	 (green (%u:to-single-float (+ 0.5 (* 0.5 (sin (+ now (/ (* pi 2) 3)))))))
	 (blue (%u:to-single-float (+ 0.5 (* 0.5 (sin (+ now (/ (* pi 4) 3)))))))
	 (dst-rect (make-instance 'sdl3:frect :%x 0.0
				  :%y 0.0
				  :%w *texture-width*
				  :%h *texture-height*)))
    (sdl3:set-render-draw-color *renderer-handler* 0 0 0 255)
    (sdl3:render-clear *renderer-handler*)

    (sdl3:set-texture-color-mod-float *texture-handler* 0.0 0.0 1.0)
    (sdl3:render-texture *renderer-handler* *texture-handler* nil dst-rect)
    
    (setf (sdl3:%x dst-rect) (/ (- +window-width+ *texture-width*) 2.0)
	  (sdl3:%y dst-rect) (/ (- +window-height+ *texture-height*) 2.0))
    (sdl3:set-texture-color-mod-float *texture-handler* red green blue)
    (sdl3:render-texture *renderer-handler* *texture-handler* nil dst-rect)
    
    (setf (sdl3:%x dst-rect) (- +window-width+ *texture-width*)
	  (sdl3:%y dst-rect) (- +window-height+ *texture-height*))
    (sdl3:set-texture-color-mod-float *texture-handler* 1.0 0.0 0.0)
    (sdl3:render-texture *renderer-handler* *texture-handler* nil dst-rect)

    (sdl3:render-present *renderer-handler*))
  :continue)

(sdl3:def-app-event 11-event (type event)
  (declare (ignore type))
  (typecase (sdl3:event-unmarshal event)
    (sdl3:quit-event :success)
    (t :continue)))

(sdl3:def-app-quit 11-quit (result)
  (declare (ignore result))
  (sdl3:destroy-texture *texture-handler*))

(defun do-color-mode-demo ()
  (renderer-init)
  (sdl3:enter-app-main-callbacks '11-init '11-iterate '11-event '11-quit))


