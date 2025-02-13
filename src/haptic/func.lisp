(in-package :sdl3)

(defwrap-fun "SDL_GetHaptics" (:pointer haptic-id)
    (t t)
  (count (:pointer :int) :ret-count 'haptic-id))

(defexport-fun "SDL_GetHapticNameForID" :string
  (instance-id haptic-id))

(defexport-fun "SDL_OpenHaptic" :pointer
  (instance-id haptic-id))

(defexport-fun "SDL_GetHapticFromID" :pointer
  (instance-id haptic-id))

(defexport-fun "SDL_GetHapticID" haptic-id
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

(defwrap-fun "SDL_HapticEffectSupported" :bool
    (t t)
  (haptic :pointer)
  (effect (:pointer (:union haptic-effect)) :direction :input))

(defwrap-fun "SDL_CreateHapticEffect" :int
    (t t)
  (haptic :pointer)
  (effect (:pointer (:union haptic-effect)) :direction :input))

(defwrap-fun "SDL_UpdateHapticEffect" :bool
    (t t)
  (haptic :pointer)
  (effect :int)
  (data (:pointer (:union haptic-effect)) :direction :input))

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

