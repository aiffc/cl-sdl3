(in-package :sdl3.demo.file-dialog)

;;; Callback invoked by SDL3 after the folder dialog is closed.
;;; filelist — NULL-terminated array of char* (NULL on cancel or error).
;;; filter   — always -1 for folder dialogs.
(cffi:defcallback open-folder-callback :void
    ((userdata :pointer)
     (filelist :pointer)
     (filter   :int))
  (declare (ignore userdata filter))
  (if (cffi:null-pointer-p filelist)
      (format t "Folder dialog: cancelled or error — ~a~%" (sdl3:get-error))
      (loop for i from 0
            for ptr = (cffi:mem-aref filelist :pointer i)
            until (cffi:null-pointer-p ptr)
            do (format t "  [~a] ~a~%" i (cffi:foreign-string-to-lisp ptr)))))

(defparameter *window-folder-handle* nil)
(defparameter *renderer-folder-handle* nil)

(sdl3:def-app-init open-folder-dialog-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example Folder Dialog" "1.0" "com.example.folder-dialog")
  (when (not (sdl3:init :video))
    (format t "~a~%" (sdl3:get-error))
    (return-from open-folder-dialog-init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer "Folder Dialog — press Ctrl+D to open" 640 120 0)
    (if (not rst)
        (progn
          (format t "~a~%" (sdl3:get-error))
          (return-from open-folder-dialog-init :failure))
        (setf *window-folder-handle*  window
              *renderer-folder-handle* renderer)))
  :continue)

(sdl3:def-app-iterate open-folder-dialog-iterate ()
  (sdl3:set-render-draw-color *renderer-folder-handle* 30 30 30 255)
  (sdl3:render-clear *renderer-folder-handle*)
  (sdl3:render-present *renderer-folder-handle*)
  :continue)

(sdl3:def-app-event open-folder-dialog-event (type event)
  (declare (ignore type))
  (let ((ev (sdl3:event-unmarshal event)))
    (typecase ev
      (sdl3:quit-event :success)
      (sdl3:keyboard-event
       ;; react only on Ctrl+D key-down, not key-repeat
       (when (and (slot-value ev 'sdl3:%down)
                  (not (slot-value ev 'sdl3:%repeat))
                  (eq (slot-value ev 'sdl3:%key) :d)
                  (intersection (slot-value ev 'sdl3:%mod) '(:lctrl :rctrl)))
         (sdl3:show-open-folder-dialog
          (cffi:callback open-folder-callback)
          (cffi:null-pointer)          ; userdata
          *window-folder-handle*
          (cffi:null-pointer)          ; default-location — NULL means OS default
          nil))                        ; single selection
       :continue)
      (t :continue))))

(sdl3:def-app-quit open-folder-dialog-quit (result)
  (declare (ignore result))
  (sdl3:destroy-renderer *renderer-folder-handle*)
  (sdl3:destroy-window *window-folder-handle*)
  (sdl3:pump-events)
  (sdl3:quit-sub-system :video)
  (sdl3:quit))

(defun do-open-folder-dialog-demo ()
  (sdl3:enter-app-main-callbacks
   'open-folder-dialog-init
   'open-folder-dialog-iterate
   'open-folder-dialog-event
   'open-folder-dialog-quit))
