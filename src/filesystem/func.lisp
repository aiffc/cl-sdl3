(in-package :sdl3)

(defexport-fun "SDL_GetBasePath" :string)

(defexport-fun "SDL_GetPrefPath" :string
  (org :string)
  (app :string))

(defexport-fun "SDL_GetUserFolder" :string
  (folder folder))

(defexport-fun "SDL_CreateDirectory" :bool
  (path :string))

(defexport-fun "SDL_EnumerateDirectory" :bool
  (path :string)
  (callback :pointer)
  (userdata :pointer))

(defexport-fun "SDL_RemovePath" :bool
  (path :string))

(defexport-fun "SDL_RenamePath" :bool
  (old :string)
  (new :string))

(defexport-fun "SDL_CopyFile" :bool
  (old :string)
  (new :string))

(defwrap-fun "SDL_GetPathInfo" :bool
    (t t)
  (path :string)
  (info (:pointer (:struct path-info)) :direction :output))

(defwrap-fun "SDL_GlobDirectory" (:pointer :string)
  (t t)
  (path :string)
  (pattern :string)
  (flags glob-flags)
  (count (:pointer :int) :ret-count :string))

(defexport-fun "SDL_GetCurrentDirectory" :string)
