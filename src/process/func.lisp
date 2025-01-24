(in-package :sdl3)

;;todo
(defexport-fun "SDL_CreateProcess" :pointer
  (args (:pointer :string))
  (pipe-studio :bool))

(defexport-fun "SDL_CreateProcessWithProperties" :pointer
  (props properties-id))

(defexport-fun "SDL_GetProcessProperties" properties-id
  (process :pointer))

(defexport-fun "SDL_ReadProcess" :pointer
  (process :pointer)
  (datasize (:pointer size-t))
  (exitcode (:pointer :int)))

(defexport-fun "SDL_GetProcessInput" :pointer
  (process :pointer))

(defexport-fun "SDL_GetProcessOutput" :pointer
  (process :pointer))

(defexport-fun "SDL_KillProcess" :bool
  (process :pointer)
  (force :bool))

(defexport-fun "SDL_WaitProcess" :bool
  (process :pointer)
  (blck :bool)
  (exitcode (:pointer :int)))

(defexport-fun "SDL_DestroyProcess" :void
  (process :pointer))
