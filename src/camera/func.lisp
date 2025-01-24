(in-package :sdl3)

(defexport-fun "SDL_GetNumCameraDrivers" :int)

(defexport-fun "SDL_GetCameraDriver" :string
  (index :int))

(defexport-fun "SDL_GetCurrentCameraDriver" :string)

(defexport-fun "SDL_GetCameras" (:pointer camera-id)
  (count (:pointer :int)))

(defexport-fun "SDL_GetCameraSupportedFormats" (:pointer (:pointer (:struct camera-spec)))
  (devid camera-id)
  (count :int))

(defexport-fun "SDL_GetCameraName" :string
  (instance-id camera-id))

(defexport-fun "SDL_GetCameraPosition" camera-position
  (instance-id camera-id))

(defexport-fun "SDL_OpenCamera" :pointer
  (instance-id camera-id)
  (spec (:pointer (:struct camera-spec))))

(defexport-fun "SDL_GetCameraPermissionState" :int
  (camera :pointer))

(defexport-fun ("SDL_GetCameraID" get-camera-id) camera-id
  (camera :pointer))

(defexport-fun "SDL_GetCameraProperties" properties-id
  (camera :pointer))

(defexport-fun "SDL_GetCameraFormat" :bool
  (camera :pointer)
  (spec (:pointer (:struct camera-spec))))

(defexport-fun "SDL_AcquireCameraFrame" :pointer
  (camera :pointer)
  (timestamp (:pointer :uint64)))

(defexport-fun "SDL_ReleaseCameraFrame" :void
  (camera :pointer)
  (frame :pointer))

(defexport-fun "SDL_CloseCamera" :void
  (camera :pointer))
