(in-package :sdl3)

(defexport-fun "SDL_HasKeyboard" :bool)

(defexport-fun "SDL_GetKeyboards" keyboard-id
  (count (:pointer :int)))

(defexport-fun "SDL_GetKeyboardNameForID" :string
  (instance-id keyboard-id))

(defexport-fun "SDL_GetKeyboardFocus" :pointer)

(defexport-fun "SDL_GetKeyboardState" (:pointer :bool)
  (numkeys (:pointer :int)))

(defexport-fun "SDL_ResetKeyboard" :void)

(defexport-fun "SDL_GetModState" keymod)

(defexport-fun "SDL_SetModState" :void
  (modstate keymod))

(defexport-fun "SDL_GetKeyFromScancode" keycode
  (scancode scancode)
  (modstate keymod)
  (key-event :bool))

(defexport-fun "SDL_GetScancodeFromKey" scancode
  (key keycode)
  (modstate (:pointer keymod)))

(defexport-fun "SDL_SetScancodeName" :bool
  (scancode scancode)
  (name :string))

(defexport-fun "SDL_GetScancodeName" :string
  (scancode scancode))

(defexport-fun "SDL_GetScancodeFromName" scancode
  (name :string))

(defexport-fun "SDL_GetKeyName" :string
  (key keycode))

(defexport-fun "SDL_GetKeyFromName" keycode
  (name :string))

(defexport-fun "SDL_StartTextInput" :bool
  (window :pointer))

(defexport-fun "SDL_StartTextInputWithProperties" :bool
  (window :pointer)
  (props properties-id))

(defexport-fun "SDL_TextInputActive" :bool
  (window :pointer))

(defexport-fun "SDL_StopTextInput" :bool
  (window :pointer))

(defexport-fun "SDL_ClearComposition" :bool
  (window :pointer))

(defexport-fun "SDL_SetTextInputArea" :bool
  (window :pointer)
  (rect (:pointer (:struct rect)))
  (cursor :int))

(defexport-fun "SDL_GetTextInputArea" :bool
  (window :pointer)
  (rect (:pointer (:struct rect)))
  (cursor (:pointer :int)))

(defexport-fun "SDL_HasScreenKeyboardSupport" :bool)

(defexport-fun "SDL_ScreenKeyboardShown" :bool
  (window :pointer))

