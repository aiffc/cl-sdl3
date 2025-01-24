(in-package :sdl3)

;; (defun create-windows-and-renderer (title width height &optional (flags 0))
;;   (let* ((window-ptr (cffi:foreign-alloc :pointer))
;; 	 (renderer-ptr (cffi:foreign-alloc :pointer))
;; 	 (rst (%create-windows-and-renderer
;; 	       title width height flags
;; 	       (cffi:mem-aptr window-ptr :pointer)
;; 	       (cffi:mem-aptr renderer-ptr :pointer))))
;;     (values rst window-ptr renderer-ptr)))
;; (export 'create-windows-and-renderer)


;; (defexport-fun "SDL_RenderDebugTextFormat" :bool
;;   (renderer :pointer))
