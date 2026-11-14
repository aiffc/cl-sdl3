(in-package :sdl3)

;; raw binding; SDL_free(NULL) is a documented no-op. Name is %free to
;; avoid shadowing cl:free.
(defexport-fun ("SDL_free" %free) :void
  (mem :pointer))
