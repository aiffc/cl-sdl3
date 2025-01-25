(in-package :sdl3)

(defexport-fun "SDL_LockJoysticks" :void)

(defexport-fun "SDL_UnlockJoysticks" :void)

(defexport-fun "SDL_HasJoystick" :bool)

(defexport-fun "SDL_GetJoysticks" (:pointer joystick-id)
  (count (:pointer :int)))

(defexport-fun ("SDL_GetJoystickNameForID" get-joystick-name-for-id) :string
  (instance-id joystick-id))

(defexport-fun ("SDL_GetJoystickPathForID" get-joystick-path-for-id) :string
  (instance-id joystick-id))

(defexport-fun ("SDL_GetJoystickPlayerIndexForID" get-joystick-player-index-for-id) :int
  (instance-id joystick-id))

(defexport-fun ("SDL_GetJoystickGUIDForID" get-joystick-guid-for-id) (:struct guid)
  (instance-id joystick-id))

(defexport-fun ("SDL_GetJoystickVendorForID" get-joystick-vendor-for-id) :uint16
  (instance-id joystick-id))

(defexport-fun ("SDL_GetJoystickProductForID" get-joystick-product-for-id) :uint16
  (instance-id joystick-id))

(defexport-fun ("SDL_GetJoystickProductVersionForID" get-joystick-product-version-for-id) :uint16
  (instance-id joystick-id))

(defexport-fun ("SDL_GetJoystickTypeForID" get-joystick-type-for-id) joystick-type
  (instance-id joystick-id))

(defexport-fun "SDL_OpenJoystick" :pointer
  (instance-id joystick-id))

(defexport-fun ("SDL_GetJoystickFromID" get-joystick-from-id) :pointer
  (instance-id joystick-id))

(defexport-fun "SDL_GetJoystickFromPlayerIndex" :pointer
  (player-index :int))

(defexport-fun "SDL_AttachVirtualJoystick" joystick-id
  (desc (:pointer (:struct virtual-joystick-desc))))

(defexport-fun "SDL_DetachVirtualJoystick" :bool
  (instance-id joystick-id))

(defexport-fun "SDL_IsJoystickVirtual" :bool
  (instance-id joystick-id))

(defexport-fun "SDL_SetJoystickVirtualAxis" :bool
  (joystick :pointer)
  (axis :int)
  (value :int16))

(defexport-fun "SDL_SetJoystickVirtualBall" :bool
  (joystick :pointer)
  (ball :int)
  (xrel :int16)
  (yrel :int16))

(defexport-fun "SDL_SetJoystickVirtualButton" :bool
  (joystick :pointer)
  (button :int)
  (down :bool))

(defexport-fun "SDL_SetJoystickVirtualHat" :bool
  (joystick :pointer)
  (hat :int)
  (value :uint8))

(defexport-fun "SDL_SetJoystickVirtualTouchpad" :bool
  (joystick :pointer)
  (touchpad :int)
  (finger :int)
  (down :bool)
  (x :float)
  (y :float)
  (pressure :float))

(defexport-fun "SDL_SendJoystickVirtualSensorData" :bool
  (joystick :pointer)
  (type sensor-type)
  (sensor-timestamp :uint64)
  (data (:pointer :float))
  (num-values :int))

(defexport-fun "SDL_GetJoystickProperties" properties-id
  (joystick :pointer))

(defexport-fun "SDL_GetJoystickName" :string
  (joystick :pointer))

(defexport-fun "SDL_GetJoystickPath" :string
  (joystick :pointer))

(defexport-fun "SDL_GetJoystickPlayerIndex" :int
  (joystick :pointer))

(defexport-fun "SDL_SetJoystickPlayerIndex" :bool
  (joystick :pointer)
  (player-index :int))

(defexport-fun ("SDL_GetJoystickGUID" get-joystick-guid) (:struct guid)
  (joystick :pointer))

(defexport-fun "SDL_GetJoystickVendor" :uint16
  (joystick :pointer))

(defexport-fun "SDL_GetJoystickProduct" :uint16
  (joystick :pointer))

(defexport-fun "SDL_GetJoystickProductVersion" :uint16
  (joystick :pointer))

(defexport-fun "SDL_GetJoystickFirmwareVersion" :uint16
  (joystick :pointer))

(defexport-fun "SDL_GetJoystickSerial" :string
  (joystick :pointer))

(defexport-fun "SDL_GetJoystickType" joystick-type
  (joystick :pointer))

(defexport-fun "SDL_GetJoystickGUIDInfo" :void
  (guid (:struct guid))
  (vendor (:pointer  :uint16))
  (product (:pointer  :uint16))
  (version (:pointer  :uint16))
  (crc16 (:pointer  :uint16)))

(defexport-fun "SDL_JoystickConnected" :bool
  (joystick :pointer))

(defexport-fun ("SDL_GetJoystickID" get-joystick-id) joystick-id
  (joystick :pointer))

(defexport-fun "SDL_GetNumJoystickAxes" :int
  (joystick :pointer))

(defexport-fun "SDL_GetNumJoystickBalls" :int
  (joystick :pointer))

(defexport-fun "SDL_GetNumJoystickHats" :int
  (joystick :pointer))

(defexport-fun "SDL_GetNumJoystickButtons" :int
  (joystick :pointer))

(defexport-fun "SDL_SetJoystickEventsEnabled" :void
  (enabled :bool))

(defexport-fun "SDL_JoystickEventsEnabled" :bool)

(defexport-fun "SDL_UpdateJoysticks" :void)

(defexport-fun "SDL_GetJoystickAxis" :int16
  (joystick :pointer)
  (axis :int))

(defexport-fun "SDL_GetJoystickAxisInitialState" :bool
  (joystick :pointer)
  (axis :int)
  (state (:pointer  :int16)))

(defexport-fun "SDL_GetJoystickBall" :bool
  (joystick :pointer)
  (ball :int)
  (dx (:pointer  :int))
  (dy (:pointer  :int)))

(defexport-fun "SDL_GetJoystickHat" :uint8
  (joystick :pointer)
  (hat :int))

(defexport-fun "SDL_GetJoystickButton" :bool
  (joystick :pointer)
  (button :int))

(defexport-fun "SDL_RumbleJoystick" :bool
  (joystick :pointer)
  (low-frequency-rumble :uint16)
  (high-frequency-rumble :uint16)
  (duration-ms :uint32))

(defexport-fun "SDL_RumbleJoystickTriggers" :bool
  (joystick :pointer)
  (left-rumble :uint16)
  (right-rumble :uint16)
  (duration-ms :uint32))

(defexport-fun ("SDL_SetJoystickLED" get-joystick-led) :bool
  (joystick :pointer)
  (red :uint8)
  (green :uint8)
  (blue :uint8))

(defexport-fun "SDL_SendJoystickEffect" :bool
  (joystick :pointer)
  (data :pointer)
  (size :int))

(defexport-fun "SDL_CloseJoystick" :void
  (joystick :pointer))

(defexport-fun "SDL_GetJoystickConnectionState" joystick-connection-state
  (joystick :pointer))

(defexport-fun "SDL_GetJoystickPowerInfo" power-state
  (joystick :pointer)
  (percent (:pointer  :int)))

