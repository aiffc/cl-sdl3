(in-package :sdl3)

(defexport-fun "SDL_SwapFloat" :float
  (x :float))

(defexport-fun "SDL_Swap16" :uint16
  (x :uint16))

(defexport-fun "SDL_Swap32" :uint32
  (x :uint32))

(defexport-fun "SDL_Swap64" :uint32
  (x :uint64))
