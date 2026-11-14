(in-package :sdl3)

;; SDL_free is defined in SDL_stdinc.h and is needed by consumers to
;; release memory returned by SDL functions (strings, lists, etc.).
;; Bound as %free for consistency with the other raw cffi bindings;
;; a plain name would shadow cl:free.
(defexport-fun ("SDL_free" %free) :void
  (mem :pointer))
