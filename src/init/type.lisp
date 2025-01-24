(in-package :sdl3)

(cffi:defbitfield init-flags
  (:init-audio      #x00000010)
  (:init-video      #x00000020)
  (:init-joystick   #x00000200)
  (:init-haptic     #x00001000)
  (:init-gamepad    #x00002000)
  (:init-events     #x00004000)
  (:init-sensor     #x00008000)
  (:init-camera     #x00010000))
