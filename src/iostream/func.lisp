(in-package :sdl3)

(defexport-fun ("SDL_IOFromFile" io-from-file) :pointer
  (file :string)
  (mode :string))

(defexport-fun ("SDL_IOFromMem" io-from-mem) :pointer
  (mem :pointer)
  (size size-t))

(defexport-fun ("SDL_IOFromConstMem" io-from-const-men) :pointer
  (mem :pointer)
  (size size-t))
(defexport-fun ("SDL_IOFromDynamicMem" io-from-dynamic-mem) :pointer)

(defexport-fun ("SDL_OpenIO" open-io) :pointer
  (iface (:pointer (:struct io-stream-interface)))
  (userdata :pointer))

(defexport-fun ("SDL_CloseIO" close-io) :bool
  (context :pointer))

(defexport-fun ("SDL_GetIOProperties" get-io-properties) properties-id
  (context :pointer))

(defexport-fun ("SDL_GetIOStatus" get-io-status) io-status
  (context :pointer))

(defexport-fun ("SDL_GetIOSize" get-io-size) :int64
  (context :pointer))

(defexport-fun ("SDL_SeekIO" seek-io) :int64
  (context :pointer)
  (offset :int64)
  (whence io-whence))

(defexport-fun ("SDL_TellIO" tell-io) :int64
  (context :pointer))

(defexport-fun ("SDL_ReadIO" read-io) size-t
  (context :pointer)
  (ptr :pointer)
  (size size-t))

(defexport-fun ("SDL_WriteIO" write-io) size-t
  (context :pointer)
  (ptr :pointer)
  (size size-t))

;; todo (defexport-fun ("SDL_IOprintf") size-t)

(defexport-fun ("SDL_FlushIO" flush-io) :bool
  (context :pointer))

(defexport-fun ("SDL_LoadFile_IO" load-file-io) :pointer
  (src :pointer)
  (data-size (:pointer size-t))
  (closeio :bool))

(defexport-fun ("SDL_LoadFile" load-file) :pointer
  (src :pointer)
  (data-size (:pointer size-t)))

(defexport-fun ("SDL_SaveFile_IO" save-file-io) :bool
  (src :pointer)
  (data :pointer)
  (data-size size-t)
  (closeio :bool))

(defexport-fun ("SDL_SaveFile") :bool
  (file :string)
  (data :pointer)
  (data-size size-t))

(defexport-fun "SDL_ReadU8" :bool
  (io :pointer)
  (value :uint8))
(defexport-fun "SDL_ReadS8" :bool
  (io :pointer)
  (value :int8))

(defexport-fun ("SDL_ReadU16LE" read-u16le) :bool
  (io :pointer)
  (value :uint16))
(defexport-fun ("SDL_ReadS16LE" read-s16le) :bool
  (io :pointer)
  (value :int16))
(defexport-fun ("SDL_ReadU16BE" read-u16be) :bool
  (io :pointer)
  (value :uint16))
(defexport-fun ("SDL_ReadS16BE" read-s16be) :bool
  (io :pointer)
  (value :int16))

(defexport-fun ("SDL_ReadU32LE" read-u32le) :bool
  (io :pointer)
  (value :uint32))
(defexport-fun ("SDL_ReadS32LE" read-s32le) :bool
  (io :pointer)
  (value :int32))
(defexport-fun ("SDL_ReadU32BE" read-u32be) :bool
  (io :pointer)
  (value :uint32))
(defexport-fun ("SDL_ReadS32BE" read-s32be) :bool
  (io :pointer)
  (value :int32))

(defexport-fun ("SDL_ReadU64LE" read-u64le) :bool
  (io :pointer)
  (value :uint64))
(defexport-fun ("SDL_ReadS64LE" read-s64le) :bool
  (io :pointer)
  (value :int64))
(defexport-fun ("SDL_ReadU64BE" read-u64be) :bool
  (io :pointer)
  (value :uint64))
(defexport-fun ("SDL_ReadS64BE" read-s64be) :bool
  (io :pointer)
  (value :int64))

(defexport-fun "SDL_WriteU8" :bool
  (io :pointer)
  (value :uint8))
(defexport-fun "SDL_WriteS8" :bool
  (io :pointer)
  (value :int8))

(defexport-fun ("SDL_WriteU16LE" write-u16le) :bool
  (io :pointer)
  (value :uint16))
(defexport-fun ("SDL_WriteS16LE" write-s16le) :bool
  (io :pointer)
  (value :int16))
(defexport-fun ("SDL_WriteU16BE" write-u16be) :bool
  (io :pointer)
  (value :uint16))
(defexport-fun ("SDL_WriteS16BE" write-s16be) :bool
  (io :pointer)
  (value :int16))

(defexport-fun ("SDL_WriteU32LE" write-u32le) :bool
  (io :pointer)
  (value :uint32))
(defexport-fun ("SDL_WriteS32LE" write-s32le) :bool
  (io :pointer)
  (value :int32))
(defexport-fun ("SDL_WriteU32BE" write-u32be) :bool
  (io :pointer)
  (value :uint32))
(defexport-fun ("SDL_WriteS32BE" write-s32be) :bool
  (io :pointer)
  (value :int32))

(defexport-fun ("SDL_WriteU64LE" write-u64le) :bool
  (io :pointer)
  (value :uint64))
(defexport-fun ("SDL_WriteS64LE" write-s64le) :bool
  (io :pointer)
  (value :int64))
(defexport-fun ("SDL_WriteU64BE" write-u64be) :bool
  (io :pointer)
  (value :uint64))
(defexport-fun ("SDL_WriteS64BE" write-s64be) :bool
  (io :pointer)
  (value :int64))
