(in-package :sdl3)

(defexport-fun "SDL_GetNumCameraDrivers" :int)

(defexport-fun "SDL_GetCameraDriver" :string
  (index :int))

(defexport-fun "SDL_GetCurrentCameraDriver" :string)

(defwrap-fun "SDL_GetCameras" (:pointer camera-id)
    (t t)
  (count (:pointer :int) :ret-cout 'camera-id))

;; todo 
(defexport-fun "SDL_GetCameraSupportedFormats" (:pointer (:pointer (:struct camera-spec)))
  (devid camera-id)
  (count :int :ret-cout))

(defexport-fun "SDL_GetCameraName" :string
  (instance-id camera-id))

(defexport-fun "SDL_GetCameraPosition" camera-position
  (instance-id camera-id))

(defwrap-fun "SDL_OpenCamera" :pointer
    (t t)
  (instance-id camera-id)
  (spec (:pointer (:struct camera-spec)) :direction :input))

(defexport-fun "SDL_GetCameraPermissionState" :int
  (camera :pointer))

(defexport-fun "SDL_GetCameraID" camera-id
  (camera :pointer))

(defexport-fun "SDL_GetCameraProperties" properties-id
  (camera :pointer))

(defwrap-fun "SDL_GetCameraFormat" :bool
    (t t)
  (camera :pointer)
  (spec (:pointer (:struct camera-spec)) :direction :output))

(defwrap-fun "SDL_AcquireCameraFrame" :pointer
    (t t)
  (camera :pointer)
  (timestamp (:pointer :uint64) :direction :output))

(defexport-fun "SDL_ReleaseCameraFrame" :void
  (camera :pointer)
  (frame :pointer))

(defexport-fun "SDL_CloseCamera" :void
  (camera :pointer))
