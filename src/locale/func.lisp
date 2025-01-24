(in-package :sdl3)

(defexport-fun "SDL_GetPreferredLocales" (:pointer (:pointer (:struct locale)))
  (count (:pointer :int)))
