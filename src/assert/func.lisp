(in-package :sdl3)

(defexport-fun "SDL_ReportAssertion" assert-state
  (data (:pointer (:struct assert-data)))
  (func :string)
  (file :string)
  (line :int))

(defexport-fun "SDL_SetAssertionHandler" :void
  (handler :pointer)
  (userdata :pointer))

(defexport-fun "SDL_GetDefaultAssertionHandler" :pointer)

(defexport-fun "SDL_GetAssertionHandler" :pointer
  (puserdata (:pointer :pointer)))

(defexport-fun "SDL_GetAssertionReport" (:pointer (:struct assert-data)))

(defexport-fun "SDL_ResetAssertionReport" :void)

