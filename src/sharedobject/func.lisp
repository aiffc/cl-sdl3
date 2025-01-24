(in-package :sdl3)

(defexport-fun "SDL_LoadObject" :pointer
  (sofile :string))

(defexport-fun "SDL_LoadFunction" :pointer
  (handle :pointer)
  (name :string))

(defexport-fun "SDL_UnloadObject" :void
  (handle :pointer))


