(in-package :sdl3)

(defexport-fun "SDL_SetHintWithPriority" :bool
  (name :string)
  (value :string)
  (priority hit-priority))

(defexport-fun "SDL_SetHint" :bool
  (name :string)
  (value :string))

(defexport-fun "SDL_ResetHint" :bool
  (name :string))

(defexport-fun "SDL_ResetHints" :void)

(defexport-fun "SDL_GetHint" :string
  (name :string))

(defexport-fun "SDL_GetHintBoolean" :bool
  (name :string)
  (default :bool))

(defexport-fun "SDL_AddHintCallback" :bool
  (name :string)
  (callback (:pointer :void))
  (userdata (:pointer :void)))

(defexport-fun "SDL_RemoveHintCallback" :void
  (name :string)
  (callback (:pointer :void))
  (userdata (:pointer :void)))
