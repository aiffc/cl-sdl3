(in-package :sdl3)

(cffi:defctype joystick-id :uint32)

(defcenum gamepad-type
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

(defcenum joystick-connection-state
  (:invalid  -1)
  :unknown
  :wired
  :wireless)

(defcenum gamepad-binding-type
  (:none 0)
  :button
  :axis
  :hat)

(deflsp-type %gamepad-biding-input-axis
  (axis :int)
  (axis-min :int)
  (axis-max :int))
(deflsp-type %gamepad-biding-input-hat
  (hat :int)
  (hat-mask :int))
(defcunion %gamepad-binding-input
  (buttong :int)
  (axis (:struct %gamepad-biding-input-axis))
  (hat (:struct %gamepad-biding-input-hat)))

(defcenum gamepad-button
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
(defcenum gamepad-axis
  (:invalid -1)
  :leftx
  :lefty
  :rightx
  :righty
  :left-trigger
  :right-trigger
  :count)
(deflsp-type %gamepad-binding-output-axis
  (axis gamepad-axis)
  (axis-min :int)
  (axis-max :int))
(defcunion %gamepad-binding-output
  (buttong gamepad-button)
  (axis (:struct %gamepad-binding-output-axis)))

(deflsp-type gamepad-binding
  (input-type gamepad-binding-type)
  (input (:union %gamepad-binding-input))
  (output-type gamepad-binding-type)
  (output (:union %gamepad-binding-output)))

(defcenum gamepad-button-label
  :unknown
  :a
  :b
  :x
  :y
  :cross
  :circle
  :square
  :triangle)
