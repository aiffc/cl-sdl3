(in-package :sdl3)

(cffi:defcenum joystick-type
  :unknown
  :gamepad
  :wheel
  :arcade-stick
  :flight-stick
  :dance-pad
  :guitar
  :drum-kit
  :arcade-pad
  :throttle
  :count)

(cffi:defcenum joystick-connection-state
  (:invalid -1)
  :unknown
  :wired
  :wireless)

(deflsp-type virtual-joystick-touchpad-desc
  (nfingers :uint16)
  (padding :uint16 :count 3))

(deflsp-type virtual-joystick-sensor-desc
  (type sensor-type)
  (rate :float))

(deflsp-type virtual-joystick-desc
  (version :uint32)
  (type :uint16)
  (padding :uint16)
  (vendor-id :uint16)
  (product-id :uint16)
  (naxes :uint16)
  (nbuttons :uint16)
  (nballs :uint16)
  (nhats :uint16)
  (ntouchpads :uint16)
  (nsensors :uint16)
  (padding2 :uint16 :count 2)
  (button-mask :uint32)
  (axis-mask :uint32)
  (name :string)
  (touchpads (:struct virtual-joystick-touchpad-desc))
  (sensors (:struct virtual-joystick-sensor-desc))
  (user-data :pointer)
  (update :pointer)
  (set-player-index :pointer)
  (rumble :pointer)
  (rumble-triggers :pointer)
  (set-led :pointer)
  (send-effect :pointer)
  (set-sensors-enabled :pointer)
  (cleanup :pointer))
