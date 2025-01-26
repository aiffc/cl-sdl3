(in-package :sdl3)

(cffi:defctype touch-id :uint64)

(cffi:defcenum touch-device-type
  (:touch_device_invalid  -1)
  :touch_device_direct
  :touch_device_indirect_absolute
  :touch_device_indirect_relative)

(deflsp-type finger 
  (id touch-id)
  (x :float)
  (y :float)
  (pressure :float))
