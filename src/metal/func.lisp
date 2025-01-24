(in-package :sdl3)

(defexport-fun ("SDL_Metal_CreateView" metal-create-view) :pointer
  (window :pointer))

(defexport-fun ("SDL_Metal_DestroyView" metal-destroy-view) :void
  (view :pointer))

(defexport-fun ("SDL_Metal_GetLayer" meta-get-layer) :pointer
  (view :pointer))
