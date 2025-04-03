(in-package :sdl3-mixer)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (declaim (inline system-relative-namestring))
  (defun system-relative-namestring (system name)
    (namestring (asdf:system-relative-pathname system name))))

;; no offical release for sdl3 mixer, so windows and mac use the newest offical release
(cffi:define-foreign-library libsdl3-mixer
  (:darwin (:or (:framework "SDL2_mixer") (:default "libSDL2_mixer")))
  (:unix (:or "libSDL3_mixer.so" "libSDL3_mixer.so.0" "libSDL3_mixer.so.0.0.0"))
  #+(or x86 x86-64)
  (:windows #.(system-relative-namestring
               :sdl3
               #+x86 "src/extr/sdl-mixer/lib/windows/x86/SDL2_mixer.dll"
               #+x86-64 "src/extr/sdl-mixer/lib/windows/x86-64/SDL2_mixer.dll"))
  (t (:default "libSDL3")))

(cffi:use-foreign-library libsdl3-mixer)
