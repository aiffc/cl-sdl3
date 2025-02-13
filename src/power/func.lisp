(in-package :sdl3)

(defwrap-fun "SDL_GetPowerInfo" power-state
    (t t)
  (seconds (:pointer :int) :direction :output)
  (percent (:pointer :int) :direction :output))
