(in-package :sdl3)

(defexport-fun ("SDL_AsyncIOFromFile" async-io-from-file) :pointer
  (file :string)
  (mode :string))

(defexport-fun ("SDL_GetAsyncIOSize" get-async-io-size) :int64
  (asyncio :pointer))

(defexport-fun ("SDL_ReadAsyncIO" read-async-io) :bool
  (asyncio :pointer)
  (ptr :pointer)
  (offset :uint64)
  (size :uint64)
  (queue :pointer)
  (userdata :pointer))

(defexport-fun ("SDL_WriteAsyncIO" write-async-io) :bool
  (asyncio :pointer)
  (ptr :pointer)
  (offset :uint64)
  (size :uint64)
  (queue :pointer)
  (userdata :pointer))

(defexport-fun ("SDL_CloseAsyncIO" close-async-io) :bool
  (asyncio :pointer)
  (fluse :bool)
  (queue :pointer)
  (userdata :pointer))

(defexport-fun ("SDL_CreateAsyncIOQueue" create-async-io-queue) :pointer)

(defexport-fun ("SDL_DestroyAsyncIOQueue" destroy-async-io-queue) :void
  (queue :pointer))

(defexport-fun ("SDL_GetAsyncIOResult" get-async-io-result) :bool
  (queue :pointer)
  (outcome (:pointer (:struct async-io-outcome))))

(defexport-fun ("SDL_WaitAsyncIOResult" wait-async-io-result) :bool
  (queue :pointer)
  (outcome (:pointer (:struct async-io-outcome)))
  (timeout :int32))

(defexport-fun ("SDL_SignalAsyncIOQueue" signal-async-io-queue) :void
  (queue :pointer))

(defexport-fun "SDL_LoadFileAsync" :bool
  (file :string)
  (queue :pointer)
  (userdata :pointer))

