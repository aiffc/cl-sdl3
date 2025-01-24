(in-package :sdl3)

(defexport-fun "SDL_GetPowerInfo" power-state
  (seconds (:pointer :int))
  (percent (:pointer :int)))
