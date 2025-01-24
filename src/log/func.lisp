(in-package :sdl3)

(defexport-fun "SDL_SetLogPriorities" :void
  (priority log-priority))

(defexport-fun "SDL_SetLogPriority" :void
  (category :int)
  (priority log-priority))

(defexport-fun "SDL_GetLogPriority" log-priority
  (category :int))

(defexport-fun "SDL_ResetLogPriorities" :void)

(defexport-fun "SDL_SetLogPriorityPrefix" :bool
  (priority log-priority)
  (prefix :string))

(defexport-fun "SDL_GetDefaultLogOutputFunction" :pointer)

(defexport-fun "SDL_GetLogOutputFunction" :void
  (callback :pointer)
  (userdata (:pointer :pointer)))

(defexport-fun "SDL_SetLogOutputFunction" :void
  (callback :pointer)
  (userdata :pointer))

(defun slog (str &rest args)
  `(eval (cffi:foreign-funcall "SDL_Log" :string ,str ,@args :void)))
(export 'slog)

(defun log-trace (category str &rest args)
  `(eval (cffi:foreign-funcall "SDL_LogTrace" :int ,category :string ,str ,@args :void)))
(export 'log-trace)

(defun log-verbose (category str &rest args)
  `(eval (cffi:foreign-funcall "SDL_LogVerbose" :int ,category :string ,str ,@args :void)))
(export 'log-verbose)

(defun log-debug (category str &rest args)
  `(eval (cffi:foreign-funcall "SDL_LogDebug" :int ,category :string ,str ,@args :void)))
(export 'log-debug)

(defun log-info (category str &rest args)
  `(eval (cffi:foreign-funcall "SDL_LogInfo" :int ,category :string ,str ,@args :void)))
(export 'log-info)

(defun log-warn (category str &rest args)
  `(eval (cffi:foreign-funcall "SDL_LogWarn" :int ,category :string ,str ,@args :void)))
(export 'log-warn)

(defun log-error (category str &rest args)
  `(eval (cffi:foreign-funcall "SDL_LogError" :int ,category :string ,str ,@args :void)))
(export 'log-error)

(defun log-critical (category str &rest args)
  `(eval (cffi:foreign-funcall "SDL_LogCritical" :int ,category :string ,str ,@args :void)))
(export 'log-critical)

(defun log-message (category priority str &rest args)
  `(eval (cffi:foreign-funcall "SDL_LogMessage" :int ,category 'log-priority ,priority :string ,str ,@args :void)))
(export 'log-message)
