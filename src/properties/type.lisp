(in-package :sdl3)

(cffi:defctype properties-id :uint32)

(cffi:defcenum property-type
  :invalid
  :pointer
  :string
  :number
  :float
  :boolean)
