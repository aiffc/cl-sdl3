(in-package :sdl3)

(cffi:defctype spin-lock :int)

(deflsp-type atomic-int
  (value :int))

(deflsp-type atomic-u32
  (value :uint32))
