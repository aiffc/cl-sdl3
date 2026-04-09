(in-package :sdl3.demo.file-dialog)

;;; Callback invoked by SDL3 after the multi-select dialog is closed.
;;; filelist — NULL-terminated array of char* (NULL on cancel or error).
;;; filter   — index of the selected filter (-1 if unknown).
(cffi:defcallback open-file-multi-callback :void
    ((userdata :pointer)
     (filelist :pointer)
     (filter   :int))
  (declare (ignore userdata))
  (if (cffi:null-pointer-p filelist)
      (format t "File dialog: cancelled or error — ~a~%" (sdl3:get-error))
      (progn
        (format t "File dialog: filter index = ~a, selected files:~%" filter)
        (loop for i from 0
              for ptr = (cffi:mem-aref filelist :pointer i)
              until (cffi:null-pointer-p ptr)
              do (format t "  [~a] ~a~%" i (cffi:foreign-string-to-lisp ptr))))))

(defparameter *window-multi-handle* nil)
(defparameter *renderer-multi-handle* nil)

(sdl3:def-app-init open-file-dialog-multi-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example File Dialog Multi" "1.0" "com.example.file-dialog-multi")
  (when (not (sdl3:init :video))
    (format t "~a~%" (sdl3:get-error))
    (return-from open-file-dialog-multi-init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer "File Dialog Multi — press SPACE to open" 640 120 0)
    (if (not rst)
        (progn
          (format t "~a~%" (sdl3:get-error))
          (return-from open-file-dialog-multi-init :failure))
        (setf *window-multi-handle*  window
              *renderer-multi-handle* renderer)))
  :continue)

(sdl3:def-app-iterate open-file-dialog-multi-iterate ()
  (sdl3:set-render-draw-color *renderer-multi-handle* 30 30 30 255)
  (sdl3:render-clear *renderer-multi-handle*)
  (sdl3:render-present *renderer-multi-handle*)
  :continue)

(sdl3:def-app-event open-file-dialog-multi-event (type event)
  (declare (ignore type))
  (let ((ev (sdl3:event-unmarshal event)))
    (typecase ev
      (sdl3:quit-event :success)
      (sdl3:keyboard-event
       ;; react only on key-down, not key-repeat
       (when (and (slot-value ev 'sdl3:%down)
                  (not (slot-value ev 'sdl3:%repeat)))
         (sdl3:show-open-file-dialog
          (cffi:callback open-file-multi-callback)
          (cffi:null-pointer)
          *window-multi-handle*
          (list (make-instance 'sdl3:dialog-file-filter
                               :%name "Lisp source (*.lisp)"
                               :%pattern "lisp")
                (make-instance 'sdl3:dialog-file-filter
                               :%name "ASDF system (*.asd)"
                               :%pattern "asd")
                (make-instance 'sdl3:dialog-file-filter
                               :%name "All files"
                               :%pattern "*"))
          (cffi:null-pointer)   ; default-location — NULL means OS default directory
          t))                   ; allow multiple selection
       :continue)
      (t :continue))))

(sdl3:def-app-quit open-file-dialog-multi-quit (result)
  (declare (ignore result))
  (sdl3:destroy-renderer *renderer-multi-handle*)
  (sdl3:destroy-window *window-multi-handle*)
  (sdl3:pump-events)
  (sdl3:quit-sub-system :video)
  (sdl3:quit))

(defun do-open-file-dialog-multi-demo ()
  (sdl3:enter-app-main-callbacks
   'open-file-dialog-multi-init
   'open-file-dialog-multi-iterate
   'open-file-dialog-multi-event
   'open-file-dialog-multi-quit))
