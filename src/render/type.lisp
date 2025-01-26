(in-package :sdl3)

(cffi:defcenum texture-access
  :static
  :streaming
  :target)

(deflsp-type texture
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

(deflsp-type vertex
  (position (:struct fpoint))
  (color (:struct fcolor))
  (tex-coord (:struct fpoint)))
