(in-package :sdl3)

(defctype thread-id :uint64)

(defcenum thread-properties
  :low
  :normal
  :high
  :time_critical)

(defcenum thread-status
  :unknown
  :alive
  :detached
  :complete)
