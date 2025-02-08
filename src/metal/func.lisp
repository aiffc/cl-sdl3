(in-package :sdl3)

(defexport-fun "SDL_Metal_CreateView" :pointer
  (window :pointer))

(defexport-fun "SDL_Metal_DestroyView" :void
  (view :pointer))

(defexport-fun "SDL_Metal_GetLayer" :pointer
  (view :pointer))
