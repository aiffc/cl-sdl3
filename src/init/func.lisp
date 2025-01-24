(in-package :sdl3)

(defexport-fun "SDL_Init" :bool
  (flags init-flags))

(defexport-fun "SDL_InitSubSystem" :bool
  (flags init-flags))

(defexport-fun "SDL_QuitSubSystem" :void
  (flags init-flags))

(defexport-fun "SDL_WasInit" init-flags
  (flags init-flags))

(defexport-fun "SDL_Quit" :void)

(defexport-fun "SDL_IsMainThread" :bool)

(defexport-fun "SDL_RunOnMainThread" :bool
  (callback (:pointer :void))
  (userdata (:pointer :void))
  (wait-complete :bool))

(defexport-fun "SDL_SetAppMetadata" :bool
  (appname :string)
  (appversion :string)
  (appidentifier :string))

(defexport-fun "SDL_SetAppMetadataProperty" :bool
  (name :string)
  (value :string))

(defexport-fun "SDL_GetAppMetadataProperty" :string
  (name :string))


