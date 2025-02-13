(in-package :sdl3)

(defexport-fun "SDL_CreateThread" :pointer
  (fn :pointer)
  (name :string)
  (data :pointer))

(defexport-fun "SDL_CreateThreadWithProperties" :pointer
  (props properties-id))

(defexport-fun "SDL_GetThreadName" :string
  (thread :pointer))

(defexport-fun "SDL_GetCurrentThreadID" thread-id)

(defexport-fun "SDL_GetThreadID" thread-id
  (thread :pointer))

(defexport-fun "SDL_SetCurrentThreadPriority" :bool
  (properties thread-properties))

(defwrap-fun "SDL_WaitThread" :void
    (t t)
  (thread :pointer)
  (status (:pointer :int) :direction :output))

(defexport-fun "SDL_GetThreadState" thread-status
  (thread :pointer))

(defexport-fun "SDL_DetachThread" :void
  (thread :pointer))

(defexport-fun "SDL_GetTLS" :pointer
  (id :pointer))

(defexport-fun "SDL_SetTLS" :bool
  (id :pointer)
  (value :pointer)
  (destructor :pointer))


(defexport-fun "SDL_CleanupTLS" :void)
