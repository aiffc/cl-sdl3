(in-package :sdl3)

(defexport-fun "SDL_SetClipboardText" :bool
  (text :string))

(defexport-fun "SDL_GetClipboardText" :char)

(defexport-fun "SDL_HasClipboardText" :bool)

(defexport-fun "SDL_SetPrimarySelectionText" :bool
  (text :string))

(defexport-fun "SDL_GetPrimarySelectionText" :char)

(defexport-fun "SDL_HasPrimarySelectionText" :bool)

(defexport-fun "SDL_SetClipboardData" :bool
  (callback :pointer)
  (cleanup :pointer)
  (userdata :pointer)
  (mime-types (:pointer :string))
  (num-mime-types size-t))

(defexport-fun "SDL_ClearClipboardData" :bool)

(defexport-fun "SDL_GetClipboardData" :pointer
  (mime-type :string)
  (size (:pointer size-t)))

(defexport-fun "SDL_HasClipboardData" :bool
  (mime-type :string))

(defexport-fun "SDL_GetClipboardMimeTypes" (:pointer :string)
  (num-mime-types (:pointer size-t)))

