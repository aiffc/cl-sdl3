(in-package :sdl3)

(defexport-fun "SDL_OpenTitleStorage" :pointer
  (override :string)
  (props properties-id))

(defexport-fun "SDL_OpenUserStorage" :pointer
  (override :string)
  (app :string)
  (props properties-id))

(defexport-fun "SDL_OpenFileStorage" :pointer
  (path :string))

(defwrap-fun "SDL_OpenStorage" :pointer
    (t t)
  (iface (:pointer (:struct storage-interface)) :direction :input)
  (userdata :pointer))

(defexport-fun "SDL_CloseStorage" :bool
  (storage :pointer))

(defexport-fun "SDL_StorageReady" :bool
  (storage :pointer))

(defwrap-fun "SDL_GetStorageFileSize" :bool
    (t t)
  (storage :pointer)
  (path :string)
  (length (:pointer :uint64) :direction :output))

(defexport-fun "SDL_ReadStorageFile" :bool
  (storage :pointer)
  (path :string)
  (destination :pointer)
  (length :uint64))

(defexport-fun "SDL_WriteStorageFile" :bool
  (storage :pointer)
  (path :string)
  (source :pointer)
  (length :uint64))

(defexport-fun "SDL_CreateStorageDirectory" :bool
  (storage :pointer)
  (path :string))

(defexport-fun "SDL_EnumerateStorageDirectory" :bool
  (storage :pointer)
  (path :string)
  (callback :pointer)
  (userdata :pointer))

(defexport-fun "SDL_RemoveStoragePath" :bool
  (storage :pointer)
  (path :string))

(defexport-fun "SDL_RenameStoragePath" :bool
  (storage :pointer)
  (oldpath :string)
  (newpath :string))

(defexport-fun "SDL_CopyStorageFile" :bool
  (storage :pointer)
  (oldpath :string)
  (newpath :string))

(defwrap-fun "SDL_GetStoragePathInfo" :bool
    (t t)
  (storage :pointer)
  (path :string)
  (info (:pointer (:struct path-info)) :direction :output))

(defexport-fun "SDL_GetStorageSpaceRemaining" :uint64
  (storage :pointer))

(defwrap-fun "SDL_GlobStorageDirectory" (:pointer :string)
    (t t)
  (storage :pointer)
  (path :string)
  (pattern :string)
  (flags glob-flags)
  (count (:pointer :int) :ret-count :string))
