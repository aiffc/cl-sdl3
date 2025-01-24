(in-package :sdl3)

(cffi:defctype thread-id :uint64)

(cffi:defcenum thread-properties
  :low
  :normal
  :high
  :time_critical)

(cffi:defcenum thread-status
  :unknown
  :alive
  :detached
  :complete)
