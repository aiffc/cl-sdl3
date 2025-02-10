(defpackage :sdl3.gpu
  (:use #:cl))

(in-package :sdl3.gpu)

(defparameter *gpu-window* nil)
(defparameter *gpu-device* nil)
(defparameter *gpu-pipeline* nil)
(defconstant +window-width+ 900)
(defconstant +window-height+ 900)

(defun load-shader (name shader-stage &key 
					(num-samplers 0) 
					(num-storage-textures 0)
					(num-storage-buffers 0)
					(num-uniform-buffers 0)
		    &aux 
		      (shader-path (concatenate 'string 
						(namestring (asdf:system-relative-pathname :sdl3/tests "test/gpu/shaders/"))
						name)))
  (unless *gpu-device*
    (error "init gpu device first"))  
  (let ((shader-format (sdl3:get-gpu-shader-formats *gpu-device*)))
    (multiple-value-bind (code code-size) (sdl3:load-file shader-path)
      (when (cffi:null-pointer-p code)
	(error "Error: ~a~%" (sdl3:get-error)))
      (let* ((shader-info (make-instance 'sdl3:gpu-shader-create-info
					 :%code-size code-size
					 :%code code
					 :%entrypoint "main"
					 :%format shader-format
					 :%stage shader-stage
					 :%num-samplers num-samplers 
					 :%num-storage-textures num-storage-textures 
					 :%num-storage-buffers num-storage-buffers
					 :%num-uniform-buffers num-uniform-buffers
					 :%props 0))
	     (shader (sdl3:create-gpu-shader *gpu-device* shader-info)))
	
	(when (cffi:null-pointer-p shader)
	  (error "Error: ~a~%" (sdl3:get-error)))
	;; windows dead here why?
	#-win32 (cffi:foreign-free code)
	shader))))

(defun make-vertex-input-state ()
  "todo"
  (make-instance 'sdl3:gpu-vertex-input-state 
		 :%vertex-buffer-descriptions (cffi:null-pointer)
		 :%num-vertex-buffers 0
		 :%vertex-attributes (cffi:null-pointer)
		 :%num-vertex-attributes 0))

(defun make-rasterizer-statge ()
  "todo"
  (make-instance 'sdl3:gpu-rasterizer-state
		 :%fill-mode :fill
		 :%cull-mode :none
		 :%front-face :counter-clockwise
		 :%depth-bias-constant-factor 0.0
		 :%depth-bias-clamp 0.0
		 :%depth-bias-slope-factor 0.0
		 :%enable-depth-bias nil
		 :%enable-depth-clip nil
		 :%padding1 0
		 :%padding2 0))

(defun make-multisample-state ()
  "todo"
  (make-instance 'sdl3:gpu-multisample-state
		 :%sample-count :1
		 :%sample-mask 0
		 :%enable-mask nil
		 :%padding1 0
		 :%padding2 0
		 :%padding3 0))

(defun make-gpu-stencil-op-state ()
  "todo"
  (make-instance 'sdl3:gpu-stencil-op-state
		 :%fail-op :invalid
		 :%pass-op :invalid
		 :%depth-fail-op :invalid
		 :%compare-op :invalid))

(defun make-depth-stencil-state ()
  "todo"
  (make-instance 'sdl3:gpu-depth-stencil-state
		 :%compare-op :never
		 :%back-stencil-state (make-gpu-stencil-op-state)
		 :%front-stencil-state (make-gpu-stencil-op-state)
		 :%compare-mask 0
		 :%write-mask 0
		 :%enable-depth-test nil
		 :%enable-depth-write nil
		 :%enable-stencil-test nil
		 :%padding1 0
		 :%padding2 0
		 :%padding3 0))

(defun make-color-target-blend-state ()
  "todo"
  (make-instance 'sdl3:gpu-color-target-blend-state
		 :%src-color-blendfactor :invalid
		 :%dst-color-blendfactor :invalid
		 :%color-blend-op :invalid
		 :%src-alpha-blendfactor :invalid
		 :%dst-alpha-blendfactor :invalid
		 :%alpha-blend-op :invalid
		 :%color-write-mask :r
		 :%enable-blend nil
		 :%enable-color-write-mask nil
		 :%padding1 0
		 :%padding2 0))

(defun make-color-target-description ()
  "todo"
  (make-instance 'sdl3:gpu-color-target-description
		 :%format (sdl3:get-gpu-swapchain-texture-format *gpu-device* *gpu-window*)
		 :%blend-state (make-color-target-blend-state)))

(defun make-graphics-pipeline-target-info ()
  "todo"
  (let ((ptr (cffi:foreign-alloc '(:struct sdl3:gpu-color-target-description))))
    (setf (cffi:mem-ref ptr '(:struct sdl3:gpu-color-target-description))
	  (make-color-target-description))
    (make-instance 'sdl3:gpu-graphics-pipeline-target-info
		   :%color-target-descriptions ptr
		   :%num-color-targets 1
		   :%depth-stencil-format :d16-unorm
		   :%has-depth-stencil-target 0
		   :%padding1 0
		   :%padding2 0
		   :%padding3 0)))

(defun make-graphics-pipeline-create-info (vshader fshader)
  (make-instance 'sdl3:gpu-graphics-pipeline-create-info
		 :%vertex-shader vshader
		 :%fragment-shader fshader
		 :%vertex-input-state (make-vertex-input-state)
		 :%primitive-type :trianglelist
		 :%rasterizer-state (make-rasterizer-statge)
		 :%multisample-state (make-multisample-state)
		 :%depth-stencil-state (make-depth-stencil-state)
		 :%target-info (make-graphics-pipeline-target-info)
		 :%props 0))
