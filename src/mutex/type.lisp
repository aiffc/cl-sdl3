(in-package :sdl3)

(cffi:defcstruct init-state
  (status (:struct atomic-int))
  (thread thread-id)
  (reserved :pointer))
