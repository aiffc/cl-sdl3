(in-package :sdl3)

(cffi:defcenum power-state
  (:powerstate-error  -1)
  :powerstate-unknown
  :powerstate-on-battery
  :powerstate-no-battery
  :powerstate-charging
  :powerstate-charged)
