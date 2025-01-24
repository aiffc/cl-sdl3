(in-package :sdl3)

(defexport-fun ("SDL_GUIDToString" guid-to-string) :void
  (guid (:struct guid))
  (psz-guid :string)
  (cb-guid :int))

(defexport-fun ("SDL_StringToGUID" string-to-guid) (:struct guid)
  (pch-guid :string))



