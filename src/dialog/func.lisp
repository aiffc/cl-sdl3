(in-package :sdl3)

(defexport-fun "SDL_ShowOpenFileDialog" :void
  (callback :pointer)
  (userdata :pointer)
  (window :pointer)
  (filters (:pointer (:struct dialog-file-filter)))
  (nfilters :int)
  (default-location :string)
  (allow-many :bool))

(defexport-fun "SDL_ShowSaveFileDialog" :void
  (callback :pointer)
  (userdata :pointer)
  (window :pointer)
  (filters (:pointer (:struct dialog-file-filter)))
  (nfilters :int)
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
