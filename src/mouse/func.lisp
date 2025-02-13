(in-package :sdl3)

(defexport-fun "SDL_HasMouse" :bool)

(defwrap-fun "SDL_GetMice" (:pointer mouse-id)
    (t t)
  (count (:pointer :int) :ret-count 'mouse-id))

(defexport-fun "SDL_GetMouseNameForID" :string
  (id mouse-id))

(defexport-fun "SDL_GetMouseFocus" :pointer)

(defwrap-fun "SDL_GetMouseState" mouse-button-flags
    (t t)
  (x (:pointer :float) :direction :output)
  (y (:pointer :float) :direction :output))

(defwrap-fun "SDL_GetGlobalMouseState" mouse-button-flags
    (t t)
  (x (:pointer :float) :direction :output)
  (y (:pointer :float) :direction :output))

(defwrap-fun "SDL_GetRelativeMouseState" mouse-button-flags
    (t t)
  (x (:pointer :float) :direction :output)
  (y (:pointer :float) :direction :output))

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
