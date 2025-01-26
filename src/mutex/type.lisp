(in-package :sdl3)

(deflsp-type init-state
  (status (:struct atomic-int))
  (thread thread-id)
  (reserved :pointer))
