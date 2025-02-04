(in-package :sdl3-image)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (declaim (inline system-relative-namestring))
  (defun system-relative-namestring (system name)
    (namestring (asdf:system-relative-pathname system name))))

(cffi:define-foreign-library libsdl3-image
  (:darwin (:or (:framework "SDL3_image") (:default "libSDL3_image")))
  (:unix (:or "libSDL3_image.so" "libSDL3_image.so.0" "libSDL3_image.so.0.2.1"))
  (:windows #.(system-relative-namestring
	       :sdl3
	       #+x86 "src/extr/sdl-image/lib/windows/x86/SDL3_image.dll"
	       #+x86-64 "src/extr/sdl-image/lib/windows/x86-64/SDL3_image.dll"))
  (t (:default "libSDL3")))

(cffi:use-foreign-library libsdl3-image)
