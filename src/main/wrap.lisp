(in-package :sdl3)


;; Provides better debugging experince
#+darwin(setf trivial-main-thread:*on-error* #'invoke-debugger)

(defmacro defmain-fun (name (argc argv) &body body)
  "ret[integer]
name -> callback name
aragc -> argument count
argv -> list of argument"
  `(cffi:defcallback ,name :int ((,argc :int) (,argv (:pointer :string)))
     ,@body))
(export 'defmain-fun)

(defun run-app (callback &rest args)
  "callback -> callback function defined by defmain-fun"
  (cffi:with-foreign-object (vargs :string (length args))
    (dotimes (i (length args))
      (cffi:lisp-string-to-foreign (nth i args)
                                   (cffi:mem-aptr vargs :string i)
                                   (length (nth i args))))
    (flet ((thunk ()
             (%run-app (length args)
                       (if args
                           (cffi:mem-aptr vargs :string)
                           (cffi:null-pointer))
                       (cffi:get-callback callback)
                       (cffi:null-pointer))))
      #+darwin
      (trivial-main-thread:with-body-in-main-thread (:blocking t)
        (float-features:with-float-traps-masked t
          (thunk)))
      #-darwin
      (thunk))))
(export 'run-app)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro def-app-init (name (argc argv) &body body)
  "ret[app-result]
name -> callback name
appstate -> a place where the app can optionally store a pointer for future use.
aragc -> the standard ANSI C main's argc; number of elements in argv.
argv -> the standard ANSI C main's argv; array of command line arguments.
"
  `(cffi:defcallback ,name app-result ((appstate (:pointer :pointer))
				       (,argc :int)
				       (,argv (:pointer :string)))
     (declare (ignore appstate))
     ,@body))
(export 'def-app-init)

(defmacro def-app-iterate (name () &body body)
  "ret[app-result]
appstate an optional pointer, provided by the app in SDL_AppInit.
"
  `(cffi:defcallback ,name app-result ((appstate :pointer))
     (declare (ignore appstate))
     ,@body))
(export 'def-app-iterate)

(defmacro def-app-event (name (event-type pevent) &body body)
  "ret[app-result]
app-state -> an optional pointer, provided by the app in SDL_AppInit.
event -> the new event for the app to examine.
event-type -> sdl event
"
  (let ((event-type-val (gensym)))
    `(cffi:defcallback ,name app-result ((appstate :pointer) (,pevent (:pointer (:union event))))
       (declare (ignore appstate))
       (cffi:with-foreign-slots (((,event-type-val type))
				 ,pevent
				 (:union event))
	 (let ((,event-type (cffi:foreign-enum-keyword 'event-type ,event-type-val)))
	   ,@body)))))
(export 'def-app-event)


(defmacro def-app-quit (name (result) &body body)
  "ret[void]
app-state -> an optional pointer, provided by the app in SDL_AppInit. 
result -> the result code that terminated the app (success or failure).
"
  `(cffi:defcallback ,name :void ((appstate :pointer) (,result app-result))
     (declare (ignore appstate))
     ,@body))
(export 'def-app-quit)

(defun enter-app-main-callbacks (appinit appiter appevent appquit &rest args)
  (cffi:with-foreign-object (vargs :string (length args))
    (dotimes (i (length args))
      (cffi:lisp-string-to-foreign (nth i args)
                                   (cffi:mem-aptr vargs :string i)
                                   (length (nth i args))))
    (flet ((thunk ()
             (%enter-app-main-callbacks (length args)
                                        (if args
                                            (cffi:mem-aptr vargs :string)
                                            (cffi:null-pointer))
                                        (cffi:get-callback appinit)
                                        (cffi:get-callback appiter)
                                        (cffi:get-callback appevent)
                                        (cffi:get-callback appquit))))
      #+darwin
      (trivial-main-thread:with-body-in-main-thread (:blocking t)
        (float-features:with-float-traps-masked t
          (thunk)))
      #-darwin
      (thunk))))
(export 'enter-app-main-callbacks)
