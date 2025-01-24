(in-package :sdl3)

(defexport-fun "SDL_GetTouchDevices" (:pointer touch-id)
  (count (:pointer :int)))

(defexport-fun "SDL_GetTouchDeviceName" :string
  (touch-id touch-id))

(defexport-fun "SDL_GetTouchDeviceType" touch-device-type
  (touch-id touch-id))

(defexport-fun "SDL_GetTouchFingers" (:pointer (:pointer (:struct finger)))
  (touch-id touch-id)
  (count :int))
