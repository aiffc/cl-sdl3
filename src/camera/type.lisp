(in-package :sdl3)

(defctype camera-id :uint32)

(deflsp-type camera-spec
  (format pixel-format)
  (color-spec colorspace)
  (width :int)
  (height :int)
  (framerate-numerator :int)
  (framerate-denominator :int))

(defcenum camera-position
  :unknown
  :front-facing
  :back-facing)
