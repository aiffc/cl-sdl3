(in-package :sdl3)

(defexport-fun "SDL_IOFromFile" :pointer
  (file :string)
  (mode :string))

(defexport-fun "SDL_IOFromMem" :pointer
  (mem :pointer)
  (size size-t))

(defexport-fun "SDL_IOFromConstMem" :pointer
  (mem :pointer)
  (size size-t))
(defexport-fun "SDL_IOFromDynamicMem" :pointer)

(defexport-fun "SDL_OpenIO" :pointer
  (iface (:pointer (:struct io-stream-interface)))
  (userdata :pointer))

(defexport-fun "SDL_CloseIO" :bool
  (context :pointer))

(defexport-fun "SDL_GetIOProperties" properties-id
  (context :pointer))

(defexport-fun "SDL_GetIOStatus" io-status
  (context :pointer))

(defexport-fun "SDL_GetIOSize" :int64
  (context :pointer))

(defexport-fun "SDL_SeekIO" :int64
  (context :pointer)
  (offset :int64)
  (whence io-whence))

(defexport-fun "SDL_TellIO" :int64
  (context :pointer))

(defexport-fun "SDL_ReadIO" size-t
  (context :pointer)
  (ptr :pointer)
  (size size-t))

(defexport-fun "SDL_WriteIO" size-t
  (context :pointer)
  (ptr :pointer)
  (size size-t))

;; todo (defexport-fun ("SDL_IOprintf") size-t)

(defexport-fun "SDL_FlushIO" :bool
  (context :pointer))

(defexport-fun "SDL_LoadFile_IO" :pointer
  (src :pointer)
  (data-size (:pointer size-t))
  (closeio :bool))

(defexport-fun "SDL_LoadFile" :pointer
  (src :pointer)
  (data-size (:pointer size-t)))

(defexport-fun "SDL_SaveFile_IO" :bool
  (src :pointer)
  (data :pointer)
  (data-size size-t)
  (closeio :bool))

(defexport-fun "SDL_SaveFile" :bool
  (file :string)
  (data :pointer)
  (data-size size-t))

(defexport-fun "SDL_ReadU8" :bool
  (io :pointer)
  (value :uint8))
(defexport-fun "SDL_ReadS8" :bool
  (io :pointer)
  (value :int8))

(defexport-fun "SDL_ReadU16LE" :bool
  (io :pointer)
  (value :uint16))
(defexport-fun "SDL_ReadS16LE" :bool
  (io :pointer)
  (value :int16))
(defexport-fun "SDL_ReadU16BE" :bool
  (io :pointer)
  (value :uint16))
(defexport-fun "SDL_ReadS16BE" :bool
  (io :pointer)
  (value :int16))

(defexport-fun "SDL_ReadU32LE" :bool
  (io :pointer)
  (value :uint32))
(defexport-fun "SDL_ReadS32LE" :bool
  (io :pointer)
  (value :int32))
(defexport-fun "SDL_ReadU32BE" :bool
  (io :pointer)
  (value :uint32))
(defexport-fun "SDL_ReadS32BE" :bool
  (io :pointer)
  (value :int32))

(defexport-fun "SDL_ReadU64LE" :bool
  (io :pointer)
  (value :uint64))
(defexport-fun "SDL_ReadS64LE" :bool
  (io :pointer)
  (value :int64))
(defexport-fun "SDL_ReadU64BE" :bool
  (io :pointer)
  (value :uint64))
(defexport-fun "SDL_ReadS64BE" :bool
  (io :pointer)
  (value :int64))

(defexport-fun "SDL_WriteU8" :bool
  (io :pointer)
  (value :uint8))
(defexport-fun "SDL_WriteS8" :bool
  (io :pointer)
  (value :int8))

(defexport-fun "SDL_WriteU16LE" :bool
  (io :pointer)
  (value :uint16))
(defexport-fun "SDL_WriteS16LE" :bool
  (io :pointer)
  (value :int16))
(defexport-fun "SDL_WriteU16BE" :bool
  (io :pointer)
  (value :uint16))
(defexport-fun "SDL_WriteS16BE" :bool
  (io :pointer)
  (value :int16))

(defexport-fun "SDL_WriteU32LE" :bool
  (io :pointer)
  (value :uint32))
(defexport-fun "SDL_WriteS32LE" :bool
  (io :pointer)
  (value :int32))
(defexport-fun "SDL_WriteU32BE" :bool
  (io :pointer)
  (value :uint32))
(defexport-fun "SDL_WriteS32BE" :bool
  (io :pointer)
  (value :int32))

(defexport-fun "SDL_WriteU64LE" :bool
  (io :pointer)
  (value :uint64))
(defexport-fun "SDL_WriteS64LE" :bool
  (io :pointer)
  (value :int64))
(defexport-fun "SDL_WriteU64BE" :bool
  (io :pointer)
  (value :uint64))
(defexport-fun "SDL_WriteS64BE" :bool
  (io :pointer)
  (value :int64))
