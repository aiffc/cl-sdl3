(in-package :sdl3)

(defun set-error (str &rest args)
  (eval `(cffi:foreign-funcall "SDL_SetError" :string ,str ,@args :bool)))
(export 'set-error)

(defexport-fun "SDL_OutOfMemory" :bool)

(defexport-fun "SDL_GetError" :string)

(defexport-fun "SDL_ClearError" :void)
