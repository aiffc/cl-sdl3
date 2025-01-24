(in-package :sdl3)

(defexport-fun "SDL_CreateThread" :pointer
  (fn :pointer)
  (name :string)
  (data :pointer))

(defexport-fun "SDL_CreateThreadWithProperties" :pointer
  (props properties-id))

(defexport-fun "SDL_GetThreadName" :string
  (thread :pointer))

(defexport-fun ("SDL_GetCurrentThreadID" get-current-thread-id) thread-id)

(defexport-fun ("SDL_GetThreadID" get-thread-id) thread-id
  (thread :pointer))

(defexport-fun "SDL_SetCurrentThreadPriority" :bool
  (properties thread-properties))

(defexport-fun "SDL_WaitThread" :void
  (thread :pointer)
  (status (:pointer :int)))

(defexport-fun "SDL_GetThreadState" thread-status
  (thread :pointer))

(defexport-fun "SDL_DetachThread" :void
  (thread :pointer))

(defexport-fun ("SDL_GetTLS" get-tls) :pointer
  (id :pointer))

(defexport-fun ("SDL_SetTLS" set-tls) :bool
  (id :pointer)
  (value :pointer)
  (destructor :pointer))


(defexport-fun ("SDL_CleanupTLS" cleanup-tls) :void)
