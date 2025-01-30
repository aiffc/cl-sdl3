(in-package :sdl3)

(defexport-fun "SDL_HasMouse" :bool)

(defexport-fun "SDL_GetMice" (:pointer mouse-id)
  (count (:pointer :int)))

(defexport-fun ("SDL_GetMouseNameForID" get-mouse-name-for-id) :string
  (id mouse-id))

(defexport-fun "SDL_GetMouseFocus" :pointer)

(defexport-fun "SDL_GetMouseState" mouse-button-flags
  (x (:pointer :float))
  (y (:pointer :float)))

(defexport-fun "SDL_GetGlobalMouseState" mouse-button-flags
  (x (:pointer :float))
  (y (:pointer :float)))

(defexport-fun "SDL_GetRelativeMouseState" mouse-button-flags
  (x (:pointer :float))
  (y (:pointer :float)))

(defexport-fun "SDL_WarpMouseInWindow" :void
  (window :pointer)
  (x :float)
  (y :float))

(defexport-fun "SDL_WarpMouseGlobal" :bool
    (x :float)
  (y :float))

(defexport-fun "SDL_SetWindowRelativeMouseMode" :bool
  (window :pointer)
  (enabled :bool))

(defexport-fun "SDL_GetWindowRelativeMouseMode" :bool
  (window :pointer))

(defexport-fun "SDL_CaptureMouse" :bool
  (enabled :bool))

(defexport-fun "SDL_CreateCursor" :pointer
  (data (:pointer :uint8))
  (mask (:pointer :uint8))
  (w :int)
  (h :int)
  (x :int)
  (y :int))

(defexport-fun "SDL_CreateColorCursor" :pointer
  (surface (:pointer (:struct surface)))
  (x :int)
  (y :int))

(defexport-fun "SDL_CreateSystemCursor" :pointer
  (id system-cursor))

(defexport-fun "SDL_SetCursor" :bool
  (cursor :pointer))

(defexport-fun "SDL_GetCursor" :pointer)

(defexport-fun "SDL_GetDefaultCursor" :pointer)

(defexport-fun "SDL_DestroyCursor" :void
  (cursor :pointer))

(defexport-fun "SDL_ShowCursor" :bool)

(defexport-fun "SDL_HideCursor" :bool)

(defexport-fun "SDL_CursorVisible" :bool)
