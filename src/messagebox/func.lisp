(in-package :sdl3)

(defexport-fun "SDL_ShowMessageBox" :bool
  (data (:pointer (:struct message-box-data)))
  (id (:pointer :int)))

(defexport-fun "SDL_ShowSimpleMessageBox" :bool
  (flags message-box-flags)
  (title :string)
  (message :string)
  (window :pointer))

