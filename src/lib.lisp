(in-package :sdl3)

(cffi:define-foreign-library libsdl3
  (:darwin (:or (:framework "SDL3") (:default "libSDL3")))
  (:unix (:or "libSDL3.so.0.1.11" "libSDL3.so.0" "libSDL3.so"))
  (:windows "SDL3.dll")
  (t (:default "libSDL3")))

(cffi:use-foreign-library libsdl3)
