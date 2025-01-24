(in-package :sdl3)

(cffi:defcenum assert-state 
  :retry
  :break
  :abort
  :ignore
  :always_ignore)

(cffi:defcstruct assert-data 
  (always-ignore :bool)
  (trigger-count :uint)
  (condition :string)
  (filename :string)
  (linenum :int)
  (function :string)
  (next (:pointer (:struct assert-data))))
