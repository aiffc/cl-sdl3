(in-package :sdl3.render.test)

(defparameter *converted-texture-width* 0)
(defparameter *converted-texture-height* 0)
(defparameter *converted-texture* (cffi:null-pointer))

(sdl3:def-app-init 17-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example Renderer Read Pixels" "1.0" "com.example.renderer-read-pixels")
  (unless (sdl3:init :video)
    (format t "~a~%" (sdl3:get-error))
    (return-from 17-init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer "examples/renderer/read-pixels" +window-width+ +window-height+ :resizable)
    (unless rst
      (format t "~a~%" (sdl3:get-error))
      (return-from 17-init :failure))
    (setf *window-handle* window
	  *renderer-handler* renderer)
    (let ((surface (sdl3:load-bmp (%u:load-texture "sample.bmp"))))
      (when (cffi:null-pointer-p surface)
	(format t "~a~%" (sdl3:get-error))
	(return-from 17-init :failure))
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
	  (return-from 17-init :failure))
	(setf *texture-handler* texture))
      (sdl3:destroy-surface surface)))
  :continue)

(sdl3:def-app-iterate 17-iterate ()
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
    (let ((surface (sdl3:render-read-pixels *renderer-handler* nil)))
      (when (cffi:null-pointer-p surface)
	(format t "error: ~a~%" (sdl3:get-error))
	(return-from 17-iterate :failure))
      (when (and (not (cffi:null-pointer-p surface))
		 (not (eql (sdl3:%format (cffi:mem-ref surface '(:struct sdl3:surface)))
			   :rgba8888))
		 (not (eql (sdl3:%format (cffi:mem-ref surface '(:struct sdl3:surface)))
			   :bgra8888)))
	(let ((new-surface (sdl3:convert-surface surface :rgba8888)))
	  (when (cffi:null-pointer-p new-surface)
	    (format t "error: ~a~%" (sdl3:get-error))
	    (return-from 17-iterate :failure))
	  (sdl3:destroy-surface surface)
	  (setf surface new-surface)))
      (cffi:with-foreign-slots (((w sdl3::w)
				 (h sdl3::h)
				 (pixels sdl3::pixels)
				 (pitch sdl3::pitch))
				surface
				(:struct sdl3:surface))
	(when (or (/= *converted-texture-width* w)
		  (/= *converted-texture-height* h))
	  (sdl3:destroy-texture *converted-texture*)
	  (setf *converted-texture* (sdl3:create-texture *renderer-handler* :rgba8888 :streaming w h))
	  (when (cffi:null-pointer-p *converted-texture*)
	    (format t "error: ~a~%" (sdl3:get-error))
	    (return-from 17-iterate :failure))
	  (setf *converted-texture-width* w
		*converted-texture-height* h))
	(dotimes (y h)
	  (let ((ppixels (cffi:inc-pointer pixels (* y pitch))))
	    (dotimes (x w)
	      (let* ((p0 (cffi:inc-pointer ppixels (* x 4)))  ;; (cffi:foreign-type-size :uint32)
		     (p1 (cffi:inc-pointer p0 1))
		     (p2 (cffi:inc-pointer p1 1))
		     (p3 (cffi:inc-pointer p2 1))
		     ;;(p0-val (cffi:mem-ref p0 :uint8))
		     (p1-val (cffi:mem-ref p1 :uint8))
		     (p2-val (cffi:mem-ref p2 :uint8))
		     (p3-val (cffi:mem-ref p3 :uint8))
		     (average (floor (/ (+ p1-val p2-val p3-val) 3)))
		     (new-val (if (> average 50) #xff #x00)))
		(if (= average 0)
		    (setf (cffi:mem-ref p0 :uint8) #xff
			  (cffi:mem-ref p3 :uint8) #xff
			  (cffi:mem-ref p1 :uint8) #x00
			  (cffi:mem-ref p2 :uint8) #x00)
		    (setf (cffi:mem-ref p1 :uint8) new-val
			  (cffi:mem-ref p2 :uint8) new-val
			  (cffi:mem-ref p3 :uint8) new-val))))))
	(sdl3:update-texture *converted-texture* nil pixels pitch)
	(sdl3:destroy-surface surface)
	(setf (sdl3:%x dst-rect) 0.0
	      (sdl3:%y dst-rect) 0.0
	      (sdl3:%w dst-rect) (%u:to-single-float (/ +window-width+ 4.0))
	      (sdl3:%h dst-rect) (%u:to-single-float (/ +window-height+ 4.0)))
	(sdl3:render-texture *renderer-handler* *converted-texture* nil dst-rect)))

    (sdl3:render-present *renderer-handler*))
  :continue)

(sdl3:def-app-event 17-event (event-type)
  (when (eql event-type :quit)
    (return-from 17-event :success))
  :continue)

(sdl3:def-app-quit 17-quit (result)
  (declare (ignore result))
  (sdl3:destroy-texture *converted-texture*)
  (sdl3:destroy-texture *texture-handler*))

(defun do-read-pixel-demo ()
  (renderer-init)
  (setf *converted-texture* (cffi:null-pointer))
  (sdl3:enter-app-main-callbacks '17-init '17-iterate '17-event '17-quit))


