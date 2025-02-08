(in-package :sdl3)

(defexport-fun "SDL_GetTicks" :uint64)

(defexport-fun "SDL_GetTicksNS" :uint64)

(defexport-fun "SDL_GetPerformanceCounter" :uint64)

(defexport-fun "SDL_GetPerformanceFrequency" :uint64)

(defexport-fun "SDL_Delay" :void
  (ms :uint32))

(defexport-fun "SDL_DelayNS" :void
  (ns :uint64))

(defexport-fun "SDL_DelayPrecise" :void
  (ns :uint64))

(defexport-fun "SDL_AddTimer" timer-id
  (interval :uint32)
  (callback :pointer)
  (userdata :pointer))

(defexport-fun "SDL_AddTimerNS" timer-id
  (interval :uint64)
  (callback :pointer)
  (userdata :pointer))

(defexport-fun "SDL_RemoveTimer" :bool
  (id timer-id))
