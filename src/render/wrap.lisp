(in-package :sdl3)

(defun create-window-and-renderer (title width height &optional (flags 0))
  (cffi:with-foreign-objects ((window-ptr '(:pointer :pointer))
			      (renderer-ptr '(:pointer :pointer)))
    (let ((rst (%create-window-and-renderer
		title width height flags
		window-ptr
		renderer-ptr)))
      (values rst (cffi:mem-ref window-ptr :pointer) (cffi:mem-ref renderer-ptr :pointer)))))
(export 'create-window-and-renderer)


;; (defexport-fun "SDL_RenderDebugTextFormat" :bool
;;   (renderer :pointer))
