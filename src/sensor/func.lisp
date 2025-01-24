(in-package :sdl3)

(defexport-fun "SDL_GetSensors" (:pointer sensor-id)
  (count (:pointer :int)))

(defexport-fun ("SDL_GetSensorNameForID" get-sensor-name-for-id) :string
  (id sensor-id))

(defexport-fun ("SDL_GetSensorTypeForID" get-sensor-type-for-id) sensor-type
  (id sensor-id))

(defexport-fun ("SDL_GetSensorNonPortableTypeForID" get-sensor-non-portable-type-for-id) :int
  (id sensor-id))

(defexport-fun "SDL_OpenSensor" :pointer
  (id sensor-id))

(defexport-fun ("SDL_GetSensorFromID" get-sensor-from-id) :pointer
  (id sensor-id))

(defexport-fun "SDL_GetSensorProperties" properties-id
  (sensor :pointer))

(defexport-fun "SDL_GetSensorName" :string
  (sensor :pointer))

(defexport-fun "SDL_GetSensorType" sensor-type
  (sensor :pointer))

(defexport-fun "SDL_GetSensorNonPortableType" :int
  (sensor :pointer))

(defexport-fun ("SDL_GetSensorID" get-sensor-id) sensor-id
  (sensor :pointer))

(defexport-fun "SDL_GetSensorData" :bool
  (sensor :pointer)
  (data (:pointer :float))
  (num-values :int))

(defexport-fun "SDL_CloseSensor" :void
  (sensor :pointer))

(defexport-fun "SDL_UpdateSensors" :void)
