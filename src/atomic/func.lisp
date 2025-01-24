(in-package :sdl3)

(defexport-fun "SDL_TryLockSpinlock" :bool
  (lock spin-lock))

(defexport-fun "SDL_LockSpinlock" :void
  (lock spin-lock))

(defexport-fun "SDL_UnlockSpinlock" :void
  (lock spin-lock))

(defexport-fun "SDL_MemoryBarrierReleaseFunction" :void)

(defexport-fun "SDL_MemoryBarrierAcquireFunction" :void)

(defexport-fun "SDL_CompareAndSwapAtomicInt" :bool
  (a (:pointer (:struct atomic-int)))
  (old-val :int)
  (new-val :int))

(defexport-fun "SDL_SetAtomicInt" :int
  (a (:pointer (:struct atomic-int)))
  (v :int))

(defexport-fun "SDL_GetAtomicInt" :int
  (a (:pointer (:struct atomic-int))))

(defexport-fun "SDL_AddAtomicInt" :int
  (a (:pointer (:struct atomic-int)))
  (v :int))

(defexport-fun "SDL_CompareAndSwapAtomicU32" :bool
  (a (:pointer (:struct atomic-u32)))
  (old-val :uint32)
  (new-val :uint32))

(defexport-fun "SDL_SetAtomicU32" :uint32
  (a (:pointer (:struct atomic-u32)))
  (v :uint32))

(defexport-fun "SDL_GetAtomicU32" :uint32
  (a (:pointer (:struct atomic-u32))))

(defexport-fun "SDL_CompareAndSwapAtomicPointer" :bool
  (a (:pointer :pointer))
  (old-val :pointer)
  (new-val :pointer))

(defexport-fun "SDL_SetAtomicPointer" :pointer
  (a (:pointer :pointer))
  (v :pointer))

(defexport-fun "SDL_GetAtomicPointer" :pointer
  (a (:pointer :pointer)))
