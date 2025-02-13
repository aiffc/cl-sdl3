(in-package :sdl3)

(defwrap-fun "SDL_GetPreferredLocales" (:pointer (:pointer (:struct locale)))
    (t t)
  (count (:pointer :int) :ret-count '(:pointer (:struct locale))))
