(in-package :sdl3)

(cffi:defctype sensor-id :uint32)

(defcenum sensor-type 
  (:invalid -1)
  :unknown
  :accel
  :gyro
  :accel_l
  :gyro_l
  :accel_r
  :gyro_r)
