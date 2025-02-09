(in-package :sdl3.gpu)

(defun triangle-init ()
  (unless (sdl3:init :video)
    (error "Error: ~a~%" (sdl3:get-error)))
  ;; use vulkan other api need to test
  (setf *gpu-window* (sdl3:create-window "gpu triangle demo" +window-width+ +window-height+ :vulkan))
  (when (cffi:null-pointer-p *gpu-window*)
    (error "Error: ~a~%" (sdl3:get-error)))
  (setf *gpu-device* (sdl3:create-gpu-device :spirv 1 (cffi:null-pointer)))
  (when (cffi:null-pointer-p *gpu-device*)
    (error "Error: ~a~%" (sdl3:get-error)))
  (format t "Success device driver is ~a~%" (sdl3:get-gpu-device-driver *gpu-device*))
  (unless (sdl3:claim-window-for-gpu-device *gpu-device* *gpu-window*)
    (error "Error: ~a~%" (sdl3:get-error)))
  (let* ((vert (load-shader "triangle/vert.spv" :vertex))
	 (frag (load-shader "triangle/frag.spv" :fragment))
	 (make-info (make-graphics-pipeline-create-info vert frag)))
    (setf *gpu-pipeline* (sdl3:create-gpu-graphics-pipeline *gpu-device* make-info))
    (when (cffi:null-pointer-p *gpu-pipeline*)
      (error "Error: ~a~%" (sdl3:get-error)))
    ;; free color taget descriptions alloc in make-graphics-pipeline-create
    (cffi:foreign-free (sdl3:%color-target-descriptions (sdl3:%target-info make-info)) )
    (sdl3:release-gpu-shader *gpu-device* vert)
    (sdl3:release-gpu-shader *gpu-device* frag))
  :continue)

(defun triangle-event (event-type)
  (cond ((eql event-type :quit) :success)
	(t :continue)))

(defun triangle-iterate (&aux 
			   (cmd (sdl3:acquire-gpu-command-buffer *gpu-device*))
			   (clear-color (make-instance 'sdl3:fcolor 
						       :%r 1.0
						       :%g 0.0
						       :%b 0.0
						       :%a 1.0)))
  (when (cffi:null-pointer-p cmd)
    (format t "~a~%" (sdl3:get-error))
    (return-from triangle-iterate :failure))
  (multiple-value-bind (rst texture w h)
      (sdl3:wait-and-acquire-gpu-swapchain-texture cmd *gpu-window*)
    (declare (ignore w h))
    (unless rst 
      (format t "~a~%" (sdl3:get-error))
      (return-from triangle-iterate :failure))
    (when (cffi:null-pointer-p texture)
      (format t "~a~%" (sdl3:get-error))
      (sdl3:submit-gpu-command-buffer cmd)
      (return-from triangle-iterate :failure))
    (let* ((color-target-info (make-instance 'sdl3:gpu-color-tage-info 
					     :%texture texture
					     :%mip-level 0
					     :%layer-or-depth-plane 0
					     :%clear-color clear-color
					     :%load-op :clear
					     :%store-op :store
					     :%resolve-texture (cffi:null-pointer)
					     :%resolve-mip-level 0
					     :%resolve-layer 0
					     :%cycle 0
					     :%cycle-resolve-texture 0
					     :%padding1 0
					     :%padding2 0))
	   (render-pass (sdl3:begin-gpu-render-pass cmd (list color-target-info) nil))) 
      (sdl3:bind-gpu-graphics-pipeline render-pass *gpu-pipeline*)
      (sdl3:draw-gpu-primitives render-pass 3 1 0 0)
      (sdl3:end-gpu-render-pass render-pass)
      (sdl3:submit-gpu-command-buffer cmd)))
  :continue)

(defun triangle-quit ()
  (sdl3:release-gpu-graphics-pipeline *gpu-device* *gpu-pipeline*)
  (sdl3:release-window-from-gpu-device *gpu-device* *gpu-window*)
  (sdl3:destroy-window *gpu-window*)
  (sdl3:destroy-gpu-device *gpu-device*))


(sdl3:def-app-init triangle-init-callback (argc argv)
  (declare (ignore argc argv))
  (triangle-init))

(sdl3:def-app-iterate triangle-iterate-callback ()
  (triangle-iterate))

(sdl3:def-app-event triangle-event-callback (event-type pevent)
  (triangle-event event-type))

(sdl3:def-app-quit triangle-quit-callback (result)
  (declare (ignore result))
  (triangle-quit))


(defun do-triangle-demo ()
  (sdl3:enter-app-main-callbacks 'triangle-init-callback
				 'triangle-iterate-callback
				 'triangle-event-callback
				 'triangle-quit-callback))
