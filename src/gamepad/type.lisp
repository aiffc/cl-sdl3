(in-package :sdl3)

(cffi:defctype joystick-id :uint32)

(cffi:defcenum gamepad-type
  (:unknown 0)
  :standard
  :xbox360
  :xboxone
  :ps3
  :ps4
  :ps5
  :nintendo-switch-pro
  :nintendo-switch-joycon-left
  :nintendo-switch-joycon-right
  :nintendo-switch-joycon-pair
  :count)

(cffi:defcenum joystick-connection-state
  (:invalid  -1)
  :unknown
  :wired
  :wireless)

(cffi:defcenum gamepad-binding-type
  (:none 0)
  :button
  :axis
  :hat)

(cffi:defcstruct %gamepad-biding-input-axis
  (axis :int)
  (axis-min :int)
  (axis-max :int))
(cffi:defcstruct %gamepad-biding-input-hat
  (hat :int)
  (hat-mask :int))
(cffi:defcunion %gamepad-binding-input
  (buttong :int)
  (axis (:struct %gamepad-biding-input-axis))
  (hat (:struct %gamepad-biding-input-hat)))

(cffi:defcenum gamepad-button
  (:invalid -1)
  :south
  :east
  :west
  :north
  :back
  :guide
  :start
  :left-stick
  :right-stick
  :left-shoulder
  :right-shoulder
  :dpad-up
  :dpad-down
  :dpad-left
  :dpad-right
  :misc1
  :right-paddle1
  :left-paddle1
  :right-paddle2
  :left-paddle2
  :touchpad
  :misc2
  :misc3
  :misc4
  :misc5
  :misc6
  :count)
(cffi:defcenum gamepad-axis
  (:invalid -1)
  :leftx
  :lefty
  :rightx
  :righty
  :left-trigger
  :right-trigger
  :count)
(cffi:defcunion %gamepad-binding-output
  (buttong gamepad-button)
  (axis gamepad-axis)
  (axis-min :int)
  (axis-max :int))

(cffi:defcstruct gamepad-binding
  (input-type gamepad-binding-type)
  (input (:union %gamepad-binding-input))
  (output-type gamepad-binding-type)
  (output (:union %gamepad-binding-output)))

(cffi:defcenum gamepad-button-label
  :unknown
  :a
  :b
  :x
  :y
  :cross
  :circle
  :square
  :triangle)
