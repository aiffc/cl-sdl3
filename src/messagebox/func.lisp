(in-package :sdl3)

(defwrap-fun "SDL_ShowMessageBox" :bool
    (t t)
  (data (:pointer (:struct message-box-data)) :direction :input)
  (id (:pointer :int)))

(defexport-fun "SDL_ShowSimpleMessageBox" :bool
  (flags message-box-flags)
  (title :string)
  (message :string)
  (window :pointer))

