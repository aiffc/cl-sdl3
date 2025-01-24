(in-package :sdl3)

(cffi:defcenum texture-access
  :static
  :streaming
  :target)

(cffi:defcstruct texture
  (format pixel-format)
  (w :int)
  (h :int)
  (refcount :int))

(cffi:defcenum renderer-logical-presentation
  :disabled
  :stretch
  :letterbox
  :overscan
  :integer_scale)

(cffi:defcstruct vertex
  (position (:struct fpoint))
  (color (:struct fcolor))
  (tex-coord (:struct fpoint)))
