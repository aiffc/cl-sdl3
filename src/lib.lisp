(in-package :sdl3)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (declaim (inline system-relative-namestring))
  (defun system-relative-namestring (system name)
    (namestring (asdf:system-relative-pathname system name))))

(cffi:define-foreign-library libsdl3
  (:darwin (:or (:framework "SDL3") (:default "libSDL3")))
  (:unix (:or "libSDL3.so" "libSDL3.so.0" "libSDL3.so.0.1.11"))
  #+(or x86 x86-64)
  (:windows #.(system-relative-namestring
               :sdl3
               #+x86 "lib/windows/x86/SDL3.dll"
               #+x86-64 "lib/windows/x86-64/SDL3.dll"))
  (t (:default "libSDL3")))

(cffi:use-foreign-library libsdl3)
