(in-package :sdl3)

(defwrap-fun "SDL_CreateProcess" :pointer
    (t t)
  (args (:pointer :string) :direction :input)
  (pipe-studio :bool))

(defexport-fun "SDL_CreateProcessWithProperties" :pointer
  (props properties-id))

(defexport-fun "SDL_GetProcessProperties" properties-id
  (process :pointer))

(defwrap-fun "SDL_ReadProcess" :pointer
    (t t)
  (process :pointer)
  (datasize (:pointer size-t) :direction :output)
  (exitcode (:pointer :int) :direction :output))

(defexport-fun "SDL_GetProcessInput" :pointer
  (process :pointer))

(defexport-fun "SDL_GetProcessOutput" :pointer
  (process :pointer))

(defexport-fun "SDL_KillProcess" :bool
  (process :pointer)
  (force :bool))

(defwrap-fun "SDL_WaitProcess" :bool
  (process :pointer)
  (blck :bool)
  (exitcode (:pointer :int) :direction :input))

(defexport-fun "SDL_DestroyProcess" :void
  (process :pointer))
