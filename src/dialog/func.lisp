(in-package :sdl3)

(defwrap-fun "SDL_ShowOpenFileDialog" :void
    (t t)
  (callback :pointer)
  (userdata :pointer)
  (window :pointer)
  (filters (:pointer (:struct dialog-file-filter)) :direction :input :bind-count nfilters)
  (nfilters :int :bind-val filters)
  (default-location :string)
  (allow-many :bool))

(defwrap-fun "SDL_ShowSaveFileDialog" :void
    (t t)
  (callback :pointer)
  (userdata :pointer)
  (window :pointer)
  (filters (:pointer (:struct dialog-file-filter)) :direction :input :bind-count nfilters)
  (nfilters :int :bind-val filters)
  (default-location :string))

(defexport-fun "SDL_ShowOpenFolderDialog" :void
  (callback :pointer)
  (userdata :pointer)
  (window :pointer)
  (default-location :string)
  (allow-many :bool))

(defexport-fun "SDL_ShowFileDialogWithProperties" :void
  (type file-dialog-type)
  (callback :pointer)
  (userdata :pointer)
  (props properties-id))
