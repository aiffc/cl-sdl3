(in-package :sdl3)

(defexport-fun "SDL_GetHaptics" (:pointer haptic-id)
  (count (:pointer :int)))

(defexport-fun ("SDL_GetHapticNameForID" get-haptic-name-for-id) :string
  (instance-id haptic-id))

(defexport-fun "SDL_OpenHaptic" :pointer
  (instance-id haptic-id))

(defexport-fun ("SDL_GetHapticFromID" get-haptic-from-id) :pointer
  (instance-id haptic-id))

(defexport-fun ("SDL_GetHapticID" get-haptic-id) haptic-id
  (haptic :pointer))

(defexport-fun "SDL_GetHapticName" :string
  (haptic :pointer))

(defexport-fun "SDL_IsMouseHaptic" :bool)

(defexport-fun "SDL_OpenHapticFromMouse" :pointer)

(defexport-fun "SDL_IsJoystickHaptic" :bool
  (joystick :pointer))

(defexport-fun "SDL_OpenHapticFromJoystick" :pointer
  (joystick :pointer))

(defexport-fun "SDL_CloseHaptic" :void
  (haptic :pointer))

(defexport-fun "SDL_GetMaxHapticEffects" :int
  (haptic :pointer))

(defexport-fun "SDL_GetMaxHapticEffectsPlaying" :int
  (haptic :pointer))

(defexport-fun "SDL_GetHapticFeatures" :uint32
  (haptic :pointer))

(defexport-fun "SDL_GetNumHapticAxes" :int
  (haptic :pointer))

(defexport-fun "SDL_HapticEffectSupported" :bool
  (haptic :pointer)
  (effect (:pointer (:union haptic-effect))))

(defexport-fun "SDL_CreateHapticEffect" :int
  (haptic :pointer)
  (effect (:pointer (:union haptic-effect))))

(defexport-fun "SDL_UpdateHapticEffect" :bool
  (haptic :pointer)
  (effect :int)
  (data (:pointer (:union haptic-effect))))

(defexport-fun "SDL_RunHapticEffect" :bool
  (haptic :pointer)
  (effect :int)
  (iterations :uint32))

(defexport-fun "SDL_StopHapticEffect" :bool
  (haptic :pointer)
  (effect :int))

(defexport-fun "SDL_DestroyHapticEffect" :void
  (haptic :pointer)
  (effect :int))

(defexport-fun "SDL_GetHapticEffectStatus" :bool
  (haptic :pointer)
  (effect :int))

(defexport-fun "SDL_SetHapticGain" :bool
  (haptic :pointer)
  (gain :int))

(defexport-fun "SDL_SetHapticAutocenter" :bool
  (haptic :pointer)
  (autocenter :int))

(defexport-fun "SDL_PauseHaptic" :bool
  (haptic :pointer))

(defexport-fun "SDL_ResumeHaptic" :bool
  (haptic :pointer))

(defexport-fun "SDL_StopHapticEffects" :bool
  (haptic :pointer))

(defexport-fun "SDL_HapticRumbleSupported" :bool
  (haptic :pointer))

(defexport-fun "SDL_InitHapticRumble" :bool
  (haptic :pointer))

(defexport-fun "SDL_PlayHapticRumble" :bool
  (haptic :pointer)
  (strength :float)
  (length :uint32))

(defexport-fun "SDL_StopHapticRumble" :bool
  (haptic :pointer))

