(in-package :sdl3)

(defcenum assert-state 
  :retry
  :break
  :abort
  :ignore
  :always_ignore)

(deflsp-type assert-data 
  (always-ignore :bool)
  (trigger-count :uint)
  (condition :string)
  (filename :string)
  (linenum :int)
  (function :string)
  (next (:pointer (:struct assert-data))))
