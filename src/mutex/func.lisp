(in-package :sdl3)

(defexport-fun "SDL_CreateMutex" :pointer)
(defexport-fun "SDL_LockMutex" :void
  (mutex :pointer))
(defexport-fun "SDL_TryLockMutex" :bool
  (mutex :pointer))
(defexport-fun "SDL_UnlockMutex" :void
  (mutex :pointer))
(defexport-fun "SDL_DestroyMutex" :void
  (mutex :pointer))

(defexport-fun "SDL_CreateRWLock" :pointer)
(defexport-fun "SDL_LockRWLockForReading" :void
  (rwlock :pointer))
(defexport-fun "SDL_LockRWLockForWriting" :void
  (rwlock :pointer))
(defexport-fun "SDL_TryLockRWLockForReading" :bool
  (rwlock :pointer))
(defexport-fun "SDL_TryLockRWLockForWriting" :bool
  (rwlock :pointer))
(defexport-fun "SDL_UnlockRWLock" :void
  (rwlock :pointer))
(defexport-fun "SDL_DestroyRWLock" :void
  (rwlock :pointer))

(defexport-fun "SDL_CreateSemaphore" :pointer
  (initval :uint32))
(defexport-fun "SDL_DestroySemaphore" :void
  (sem :pointer))
(defexport-fun "SDL_WaitSemaphore" :void
  (sem :pointer))
(defexport-fun "SDL_TryWaitSemaphore" :bool
  (sem :pointer))
(defexport-fun "SDL_WaitSemaphoreTimeout" :bool
  (sem :pointer)
  (timeout :int32))
(defexport-fun "SDL_SignalSemaphore" :void
  (sem :pointer))
(defexport-fun "SDL_GetSemaphoreValue" :uint32
  (sem :pointer))

(defexport-fun "SDL_CreateCondition" :pointer)
(defexport-fun "SDL_DestroyCondition" :void
  (cod :pointer))
(defexport-fun "SDL_SignalCondition" :void
  (cod :pointer))
(defexport-fun "SDL_BroadcastCondition" :void
  (cod :pointer))
(defexport-fun "SDL_WaitCondition" :void
  (cod :pointer)
  (mutex :pointer))
(defexport-fun "SDL_WaitConditionTimeout" :bool
  (cod :pointer)
  (mutex :pointer)
  (timeout :int32))

(defexport-fun "SDL_ShouldInit" :bool
  (state (:pointer (:struct init-state))))
(defexport-fun "SDL_ShouldQuit" :bool
  (state (:pointer (:struct init-state))))
(defexport-fun "SDL_SetInitialized" :void
  (state (:pointer (:struct init-state)))
  (initialized :bool))
