(in-package :sdl3-image)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (declaim (inline system-relative-namestring))
  (defun system-relative-namestring (system name)
    (namestring (asdf:system-relative-pathname system name))))

(cffi:define-foreign-library libsdl3-ttf
  (:darwin (:or (:framework "SDL3_ttf") (:default "libSDL3_ttf")))
  (:unix (:or "libSDL3_ttf.so" "libSDL3_ttf.so.0" "libSDL3_ttf.so.0.1.1"))
  #+(or x86 x86-64)
  (:windows #.(system-relative-namestring
               :sdl3
               #+x86 "src/extr/sdl-ttf/lib/windows/x86/SDL3_ttf.dll"
               #+x86-64 "src/extr/sdl-ttf/lib/windows/x86-64/SDL3_ttf.dll"))
  (t (:default "libSDL3")))

(cffi:use-foreign-library libsdl3-ttf)
