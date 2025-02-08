(in-package :sdl3)

(defexport-fun "SDL_GUIDToString" :void
  (guid (:struct guid))
  (psz-guid :string)
  (cb-guid :int))

(defexport-fun "SDL_StringToGUID" (:struct guid)
  (pch-guid :string))



