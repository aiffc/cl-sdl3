(in-package :sdl3)

(defexport-fun "SDL_AsyncIOFromFile" :pointer
  (file :string)
  (mode :string))

(defexport-fun "SDL_GetAsyncIOSize" :int64
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

(defexport-fun "SDL_CreateAsyncIOQueue" :pointer)

(defexport-fun "SDL_DestroyAsyncIOQueue" :void
  (queue :pointer))

(defwrap-fun "SDL_GetAsyncIOResult"  :bool
    (t t)
  (queue :pointer)
  (outcome (:pointer (:struct async-io-outcome)) :direction :output))

(defwrap-fun "SDL_WaitAsyncIOResult"  :bool
    (t t)
  (queue :pointer)
  (outcome (:pointer (:struct async-io-outcome)) :direction :output)
  (timeout :int32))

(defexport-fun "SDL_SignalAsyncIOQueue" :void
  (queue :pointer))

(defexport-fun "SDL_LoadFileAsync" :bool
  (file :string)
  (queue :pointer)
  (userdata :pointer))

