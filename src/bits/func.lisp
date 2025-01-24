(in-package :sdl3)

(defexport-fun "SDL_MostSignificantBitIndex32" :int
  (x :uint32))

(defexport-fun "SDL_HasExactlyOneBitSet32" :bool
  (x :uint32))
