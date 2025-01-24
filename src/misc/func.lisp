(in-package :sdl3)

(defexport-fun ("SDL_OpenURL" open-url) :bool
  (url :string))
