(in-package :sdl3)

(cffi:defbitfield init-flags
  (:audio      #x00000010)
  (:video      #x00000020)
  (:joystick   #x00000200)
  (:haptic     #x00001000)
  (:gamepad    #x00002000)
  (:events     #x00004000)
  (:sensor     #x00008000)
  (:camera     #x00010000))
