(in-package :sdl3)

(defexport-fun "SDL_SetMainReady" :void)

(defwrap-fun "SDL_RunApp" :int ()
  (argc :int)
  (argv (:pointer :string))
  (mainFunction :pointer)
  (reserved :pointer))

(defwrap-fun "SDL_EnterAppMainCallbacks" :int ()
  (argc :int :bind-val argv)
  (argv (:pointer :string))
  (appinit :pointer)
  (appiter :pointer)
  (appevent :pointer)
  (appquit :pointer))

(defexport-fun "SDL_RegisterApp" :bool
  (name (:pointer :string))
  (style :uint32)
  (hInst :pointer))

(defexport-fun "SDL_UnregisterApp" :void)

(defexport-fun "SDL_GDKSuspendComplete" :void)
