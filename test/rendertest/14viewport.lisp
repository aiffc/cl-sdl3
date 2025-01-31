(in-package :sdl3.render.test)

(sdl3:def-app-init 14-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example Renderer Viewport" "1.0" "com.example.renderer-viewport")
  (unless (sdl3:init :video)
    (format t "~a~%" (sdl3:get-error))
    (return-from 14-init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer "examples/renderer/viewport" +window-width+ +window-height+ :resizable)
    (unless rst
      (format t "~a~%" (sdl3:get-error))
      (return-from 14-init :failure))
    (setf *window-handle* window
	  *renderer-handler* renderer)
    (let ((surface (sdl3:load-bmp (%u:load-texture "sample.bmp"))))
      (when (cffi:null-pointer-p surface)
	(format t "~a~%" (sdl3:get-error))
	(return-from 14-init :failure))
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
	  (return-from 14-init :failure))
	(setf *texture-handler* texture))
      (sdl3:destroy-surface surface)))
  :continue)

(sdl3:def-app-iterate 14-iterate ()
  (let* ((dst-rect (make-instance 'sdl3:frect :%x 0.0
					      :%y 0.0
					      :%w *texture-width*
					      :%h *texture-height*))
	 (viewport (make-instance 'sdl3:rect :%x 0
					     :%y 0
					     :%w (floor (/ +window-width+ 2))
					     :%h (floor (/ +window-height+ 2)))))
    (sdl3:set-render-draw-color *renderer-handler* 0 0 0 255)
    (sdl3:render-clear *renderer-handler*)
    (sdl3:set-render-viewport *renderer-handler* viewport)
    (sdl3:render-texture *renderer-handler* *texture-handler* nil dst-rect)

    (setf (sdl3:%x viewport) (floor (/ +window-width+ 2))
	  (sdl3:%y viewport) (floor (/ +window-height+ 2))
	  (sdl3:%w viewport) (floor (/ +window-width+ 2))
	  (sdl3:%h viewport) (floor (/ +window-height+ 2)))
    (sdl3:set-render-viewport *renderer-handler* viewport)
    (sdl3:render-texture *renderer-handler* *texture-handler* nil dst-rect)
    
    (setf (sdl3:%x viewport) 0
	  (sdl3:%y viewport) (floor (- +window-height+ (/ +window-height+ 5)))
	  (sdl3:%w viewport) (floor (/ +window-width+ 5))
	  (sdl3:%h viewport) (floor (/ +window-height+ 5)))
    (sdl3:set-render-viewport *renderer-handler* viewport)
    (sdl3:render-texture *renderer-handler* *texture-handler* nil dst-rect)

    (setf (sdl3:%x viewport) 100
	  (sdl3:%y viewport) 200
	  (sdl3:%w viewport) +window-width+
	  (sdl3:%h viewport) +window-height+
	  (sdl3:%y dst-rect) -50.0)
    (sdl3:set-render-viewport *renderer-handler* viewport)
    (sdl3:render-texture *renderer-handler* *texture-handler* nil dst-rect)

    (sdl3:render-present *renderer-handler*))
  :continue)

(sdl3:def-app-event 14-event (event-type pevent)
  (when (eql event-type :quit)
    (return-from 14-event :success))
  :continue)

(sdl3:def-app-quit 14-quit (result)
  (declare (ignore result))
  (sdl3:destroy-texture *texture-handler*))

(defun do-viewport-demo ()
  (renderer-init)
  (sdl3:enter-app-main-callbacks '14-init '14-iterate '14-event '14-quit))


