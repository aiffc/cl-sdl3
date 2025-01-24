(in-package :sdl3)

(defexport-fun "SDL_GetGlobalProperties" properties-id)

(defexport-fun "SDL_CreateProperties" properties-id)

(defexport-fun "SDL_CopyProperties" :bool
  (src properties-id)
  (dst properties-id))

(defexport-fun "SDL_LockProperties" :bool
  (prop properties-id))

(defexport-fun "SDL_UnlockProperties" :void
  (prop properties-id))

(defexport-fun "SDL_SetPointerPropertyWithCleanup" :bool
  (prop properties-id)
  (name :string)
  (value :pointer)
  (cleanup :pointer)
  (user-data :pointer))

(defexport-fun "SDL_SetPointerProperty" :bool
  (prop properties-id)
  (name :string)
  (value :pointer))

(defexport-fun "SDL_SetStringProperty" :bool
  (prop properties-id)
  (name :string)
  (value :string))

(defexport-fun "SDL_SetNumberProperty" :bool
  (prop properties-id)
  (name :string)
  (value :int64))

(defexport-fun "SDL_SetFloatProperty" :bool
  (prop properties-id)
  (name :string)
  (value :float))

(defexport-fun "SDL_SetBooleanProperty" :bool
  (prop properties-id)
  (name :string)
  (value :bool))

(defexport-fun "SDL_HasProperty" :bool
  (prop properties-id)
  (name :string))

(defexport-fun "SDL_GetPropertyType" property-type
  (prop properties-id)
  (name :string))

(defexport-fun "SDL_GetPointerProperty" :pointer
  (prop properties-id)
  (name :string)
  (default-value :pointer))

(defexport-fun "SDL_GetStringProperty" :string
  (prop properties-id)
  (name :string)
  (default-value :string))

(defexport-fun "SDL_GetNumberProperty" :int64
  (prop properties-id)
  (name :string)
  (default-value :int64))

(defexport-fun "SDL_GetFloatProperty" :float
  (prop properties-id)
  (name :string)
  (default-value :float))

(defexport-fun "SDL_GetBooleanProperty" :bool
  (prop properties-id)
  (name :string)
  (default-value :bool))

(defexport-fun "SDL_ClearProperty" :bool
  (prop properties-id)
  (name :string))

(defexport-fun "SDL_EnumerateProperties" :bool
  (prop properties-id)
  (callback :pointer)
  (userdata :pointer))

(defexport-fun "SDL_DestroyProperties" :void
  (prop properties-id))
