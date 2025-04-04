(in-package :sdl3)

(defcenum flip-mode
  :none
  :horizontal
  :vertical)

(defcenum scale-mode
  :nearest
  :linear)

(defbitfield surface-flags 
  (:preallocated #x1)
  (:lock-needed  #x2)
  (:locked       #x3)
  (:simd-aligned #x4))

(deflsp-type surface
  (flags surface-flags)
  (format pixel-format)
  (w :int)
  (h :int)
  (pitch :int)
  (pixels :pointer)
  (refcount :int)
  (reserved :pointer))
