(in-package :sdl3)

(cffi:defcstruct rect
  (x :int)
  (y :int)
  (w :int)
  (h :int))

(cffi:defcstruct frect
  (x :float)
  (y :float)
  (w :float)
  (h :float))

(cffi:defcstruct point
  (x :int)
  (y :int))

(cffi:defcstruct fpoint
  (x :float)
  (y :float))
