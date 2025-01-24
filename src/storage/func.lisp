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

(defexport-fun "SDL_OpenStorage" :pointer
  (iface (:pointer (:struct storage-interface)))
  (userdata :pointer))

(defexport-fun "SDL_CloseStorage" :bool
  (storage :pointer))

(defexport-fun "SDL_StorageReady" :bool
  (storage :pointer))

(defexport-fun "SDL_GetStorageFileSize" :bool
  (storage :pointer)
  (path :string)
  (length (:pointer :uint64)))

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

(defexport-fun "SDL_GetStoragePathInfo" :bool
  (storage :pointer)
  (path :string)
  (info (:pointer (:struct path-info))))

(defexport-fun "SDL_GetStorageSpaceRemaining" :uint64
  (storage :pointer))

(defexport-fun "SDL_GlobStorageDirectory" (:pointer :string)
  (storage :pointer)
  (path :string)
  (pattern :string)
  (flags glob-flags)
  (count (:pointer :int)))
