(in-package :sdl3)

(defexport-fun "SDL_ComposeCustomBlendMode" blend-mode
  (src-color-factor blend-factor)
  (dst-color-factor blend-factor)
  (color-operation blend-operation)
  (src-alpha-factor blend-factor)
  (dst-alpha-factor blend-factor)
  (alpha-operation blend-operation))

