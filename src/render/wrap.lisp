(in-package :sdl3)

;; (defun create-window-and-renderer (title width height &optional (flags 0))
;;   (cffi:with-foreign-objects ((window-ptr '(:pointer :pointer))
;; 			      (renderer-ptr '(:pointer :pointer)))
;;     (let ((rst (%create-window-and-renderer
;; 		title width height flags
;; 		window-ptr
;; 		renderer-ptr)))
;;       (values rst (cffi:mem-ref window-ptr :pointer) (cffi:mem-ref renderer-ptr :pointer)))))
;; (export 'create-window-and-renderer)


;; (defun render-points (renderer points &aux (count (length points)))
;;   (cffi:with-foreign-object (ptr '(:struct fpoint) count)
;;     (dotimes (i count)
;;       (setf (cffi:mem-aref ptr '(:struct fpoint) i)
;; 	    (elt points i)))
;;     (%render-points renderer ptr count)))
;; (export 'rende-points)

;; (defun render-lines (renderer points &aux (count (length points)))
;;   (cffi:with-foreign-object (ptr '(:struct fpoint) count)
;;     (dotimes (i count)
;;       (setf (cffi:mem-aref ptr '(:struct fpoint) i)
;; 	    (elt points i)))
;;     (%render-lines renderer ptr count)))
;; (export 'render-lines)



;; (defwrap-fun "SDL_RenderRect" :bool
;;   (renderer :pointer)
;;   (rect (:pointer (:struct frect))))
;; (defwrap-fun "SDL_RenderRects" :bool
;;   (renderer :pointer)
;;   (rects (:pointer (:struct frect)))
;;   (count :int))
;; (defwrap-fun "SDL_RenderFillRect" :bool
;;   (renderer :pointer)
;;   (rects (:pointer (:struct frect))))
;; (defwrap-fun "SDL_RenderFillRects" :bool
;;   (renderer :pointer)
;;   (rects (:pointer (:struct frect)))
;;   (count :int))
