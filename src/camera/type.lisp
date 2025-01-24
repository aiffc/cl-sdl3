(in-package :sdl3)

(cffi:defctype camera-id :uint32)

(cffi:defcstruct camera-spec
  (format pixel-format)
  (color-spec colorspace)
  (width :int)
  (height :int)
  (framerate-numerator :int)
  (framerate-denominator :int))

(cffi:defcenum camera-position
  :unknown
  :front-facing
  :back-facing)
