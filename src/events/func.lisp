(in-package :sdl3)

(defexport-fun "SDL_PumpEvents" :void)

(defexport-fun "SDL_PeepEvents" :int
  (events (:pointer (:union event)))
  (numevents :int)
  (action event-action)
  (min-type :uint32)
  (max-type :uint32))

(defexport-fun "SDL_HasEvent" :bool
  (type :uint32))

(defexport-fun "SDL_HasEvents" :bool
  (min-type :uint32)
  (max-type :uint32))

(defexport-fun "SDL_FlushEvent" :void
  (type :uint32))

(defexport-fun "SDL_FlushEvents" :void
  (min-type :uint32)
  (max-type :uint32))

(defexport-fun "SDL_PollEvent" :bool
  (event (:pointer (:union event))))

(defexport-fun "SDL_WaitEvent" :bool
  (event (:pointer (:union event))))

(defexport-fun "SDL_WaitEventTimeout" :bool
  (event (:pointer (:union event)))
  (timeout-ms :int32))

(defexport-fun "SDL_PushEvent" :bool
  (event (:pointer (:union event))))

(defexport-fun "SDL_SetEventFilter" :void
  (filter :pointer)
  (userdata :pointer))

(defexport-fun "SDL_GetEventFilter" :bool
  (filter (:pointer :pointer))
  (userdata (:pointer :pointer)))

(defexport-fun "SDL_AddEventWatch" :bool
  (filter :pointer)
  (userdata :pointer))

(defexport-fun "SDL_RemoveEventWatch" :void
  (filter :pointer)
  (userdata :pointer))

(defexport-fun "SDL_FilterEvents" :void
  (filter :pointer)
  (userdata :pointer))

(defexport-fun "SDL_SetEventEnabled" :void
  (type :uint32)
  (enable :bool))

(defexport-fun "SDL_EventEnabled" :bool
  (type :uint32))

(defexport-fun "SDL_RegisterEvents" :uint32
  (numevents :int))

(defexport-fun "SDL_GetWindowFromEvent" :pointer
  (events (:pointer (:union event))))
