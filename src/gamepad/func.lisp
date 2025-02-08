(in-package :sdl3)

(defexport-fun "SDL_AddGamepadMapping" :int
  (mapping :string))

(defexport-fun "SDL_AddGamepadMappingsFromIO" :int
  (src :pointer)
  (closeio :bool))

(defexport-fun "SDL_AddGamepadMappingsFromFile" :int
  (file :string))

(defexport-fun "SDL_ReloadGamepadMappings" :bool)

(defexport-fun "SDL_GetGamepadMappings" (:pointer :string)
  (count (:pointer :int)))

(defexport-fun "SDL_GetGamepadMappingForGUID" :string
  (guid (:struct guid)))

(defexport-fun "SDL_GetGamepadMapping" :string
  (gamepad :pointer))

(defexport-fun "SDL_SetGamepadMapping" :bool
  (instance-id joystick-id)
  (mapping :string))

(defexport-fun "SDL_HasGamepad" :bool)

(defexport-fun "SDL_GetGamepads" (:pointer joystick-id)
  (count (:pointer :int)))

(defexport-fun "SDL_IsGamepad" :bool
  (instance-id joystick-id))

(defexport-fun "SDL_GetGamepadNameForID" :string
  (instance-id joystick-id))

(defexport-fun "SDL_GetGamepadPathForID" :string
  (instance-id joystick-id))

(defexport-fun "SDL_GetGamepadPlayerIndexForID" :int
  (instance-id joystick-id))

(defexport-fun "SDL_GetGamepadGUIDForID" (:struct guid)
  (instance-id joystick-id))

(defexport-fun "SDL_GetGamepadVendorForID" :uint16
  (instance-id joystick-id))

(defexport-fun "SDL_GetGamepadProductForID" :uint16
  (instance-id joystick-id))

(defexport-fun "SDL_GetGamepadProductVersionForID" :uint16
  (instance-id joystick-id))

(defexport-fun "SDL_GetGamepadTypeForID" gamepad-type
  (instance-id joystick-id))

(defexport-fun "SDL_GetRealGamepadTypeForID" gamepad-type
  (instance-id joystick-id))

(defexport-fun "SDL_GetGamepadMappingForID" :string
  (instance-id joystick-id))

(defexport-fun "SDL_OpenGamepad" :pointer
  (instance-id joystick-id))

(defexport-fun "SDL_GetGamepadFromID" :pointer
  (instance-id joystick-id))

(defexport-fun "SDL_GetGamepadFromPlayerIndex" :pointer
  (player-index :int))

(defexport-fun "SDL_GetGamepadProperties" properties-id
  (gamepad :pointer))

(defexport-fun "SDL_GetGamepadID" joystick-id
  (gamepad :pointer))

(defexport-fun "SDL_GetGamepadName" :string
  (gamepad :pointer))

(defexport-fun "SDL_GetGamepadPath" :string
  (gamepad :pointer))

(defexport-fun "SDL_GetGamepadType" gamepad-type
  (gamepad :pointer))

(defexport-fun "SDL_GetRealGamepadType" gamepad-type
  (gamepad :pointer))

(defexport-fun "SDL_GetGamepadPlayerIndex" :int
  (gamepad :pointer))

(defexport-fun "SDL_SetGamepadPlayerIndex" :bool
  (gamepad :pointer)
  (player-index :int))

(defexport-fun "SDL_GetGamepadVendor" :uint16
  (gamepad :pointer))

(defexport-fun "SDL_GetGamepadProduct" :uint16
  (gamepad :pointer))

(defexport-fun "SDL_GetGamepadProductVersion" :uint16
  (gamepad :pointer))

(defexport-fun "SDL_GetGamepadFirmwareVersion" :uint16
  (gamepad :pointer))

(defexport-fun "SDL_GetGamepadSerial" :string
  (gamepad :pointer))

(defexport-fun "SDL_GetGamepadSteamHandle" :uint64
  (gamepad :pointer))

(defexport-fun "SDL_GetGamepadConnectionState" joystick-connection-state
  (gamepad :pointer))

(defexport-fun "SDL_GetGamepadPowerInfo" power-state
  (gamepad :pointer)
  (percent (:pointer  :int)))

(defexport-fun "SDL_GamepadConnected" :bool
  (gamepad :pointer))

(defexport-fun "SDL_GetGamepadJoystick" :pointer
  (gamepad :pointer))

(defexport-fun "SDL_SetGamepadEventsEnabled" :void
  (enabled :bool))

(defexport-fun "SDL_GamepadEventsEnabled" :bool)

(defexport-fun "SDL_GetGamepadBindings" (:pointer (:pointer (:struct gamepad-binding)))
  (gamepad :pointer)
  (count (:pointer  :int)))

(defexport-fun "SDL_UpdateGamepads" :void
  )

(defexport-fun "SDL_GetGamepadTypeFromString" gamepad-type
  (str :string))

(defexport-fun "SDL_GetGamepadStringForType" :string
  (type gamepad-type))

(defexport-fun "SDL_GetGamepadAxisFromString" gamepad-axis
  (str :string))

(defexport-fun "SDL_GetGamepadStringForAxis" :string
  (axis gamepad-axis))

(defexport-fun "SDL_GamepadHasAxis" :bool
  (gamepad :pointer)
  (axis gamepad-axis))

(defexport-fun "SDL_GetGamepadAxis" :int16
  (gamepad :pointer)
  (axis gamepad-axis))

(defexport-fun "SDL_GetGamepadButtonFromString" gamepad-button
  (str :string))

(defexport-fun "SDL_GetGamepadStringForButton" :string
  (button gamepad-button))

(defexport-fun "SDL_GamepadHasButton" :bool
  (gamepad :pointer)
  (button gamepad-button))

(defexport-fun "SDL_GetGamepadButton" :bool
  (gamepad :pointer)
  (button gamepad-button))

(defexport-fun "SDL_GetGamepadButtonLabelForType" gamepad-button-label
  (type gamepad-type)
  (button gamepad-button))

(defexport-fun "SDL_GetGamepadButtonLabel" gamepad-button-label
  (gamepad :pointer)
  (button gamepad-button))

(defexport-fun "SDL_GetNumGamepadTouchpads" :int
  (gamepad :pointer))

(defexport-fun "SDL_GetNumGamepadTouchpadFingers" :int
  (gamepad :pointer)
  (touchpad :int))

(defexport-fun "SDL_GetGamepadTouchpadFinger" :bool
  (gamepad :pointer)
  (touchpad :int)
  (finger :int)
  (down (:pointer  :bool))
  (x (:pointer  :float))
  (y (:pointer  :float))
  (pressure (:pointer  :float)))

(defexport-fun "SDL_GamepadHasSensor" :bool
  (gamepad :pointer)
  (type sensor-type))

(defexport-fun "SDL_SetGamepadSensorEnabled" :bool
  (gamepad :pointer)
  (type sensor-type)
  (enabled :bool))

(defexport-fun "SDL_GamepadSensorEnabled" :bool
  (gamepad :pointer)
  (type sensor-type))

(defexport-fun "SDL_GetGamepadSensorDataRate" :float
  (gamepad :pointer)
  (type sensor-type))

(defexport-fun "SDL_GetGamepadSensorData" :bool
  (gamepad :pointer)
  (type sensor-type)
  (data (:pointer  :float))
  (num-values :int))

(defexport-fun "SDL_RumbleGamepad" :bool
  (gamepad :pointer)
  (low-frequency-rumble :uint16)
  (high-frequency-rumble :uint16)
  (duration-ms :uint32))

(defexport-fun "SDL_RumbleGamepadTriggers" :bool
  (gamepad :pointer)
  (left-rumble :uint16)
  (right-rumble :uint16)
  (duration-ms :uint32))

(defexport-fun "SDL_SetGamepadLED" :bool
  (gamepad :pointer)
  (red :uint8)
  (green :uint8)
  (blue :uint8))

(defexport-fun "SDL_SendGamepadEffect" :bool
  (gamepad :pointer)
  (data :pointer)
  (size :int))

(defexport-fun "SDL_CloseGamepad" :void
  (gamepad :pointer))

(defexport-fun "SDL_GetGamepadAppleSFSymbolsNameForButton" :string
  (gamepad :pointer)
  (button gamepad-button))

(defexport-fun "SDL_GetGamepadAppleSFSymbolsNameForAxis" :string
  (gamepad :pointer)
  (axis gamepad-axis))

