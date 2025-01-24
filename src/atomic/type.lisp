(in-package :sdl3)

(cffi:defctype spin-lock :int)

(cffi:defcstruct atomic-int
  (value :int))

(cffi:defcstruct atomic-u32
  (value :uint32))
