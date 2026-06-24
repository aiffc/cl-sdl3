(in-package :sdl3.demo.menu)

(defparameter *window-system* nil)
(defparameter *renderer-system* nil)

;;; Right mouse button number in SDL3
(defconstant +button-right+ 3)

(sdl3:def-app-init system-menu-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example System Menu" "1.0" "com.example.menu")
  (when (not (sdl3:init :video))
    (format t "~a~%" (sdl3:get-error))
    (return-from system-menu-init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer
       "System Menu — right-click to open" 640 200 0)
    (if (not rst)
        (progn
          (format t "~a~%" (sdl3:get-error))
          (return-from system-menu-init :failure))
        (setf *window-system*   window
              *renderer-system* renderer)))
  :continue)

(sdl3:def-app-iterate system-menu-iterate ()
  (sdl3:set-render-draw-color *renderer-system* 30 30 30 255)
  (sdl3:render-clear *renderer-system*)
  (sdl3:set-render-draw-color *renderer-system* 200 200 200 255)
  (sdl3:render-debug-text *renderer-system* 160.0 92.0 "Right-click anywhere to open the system menu.")
  (sdl3:render-present *renderer-system*)
  :continue)

(sdl3:def-app-event system-menu-event (type event)
  (declare (ignore type))
  (let ((ev (sdl3:event-unmarshal event)))
    (typecase ev
      (sdl3:quit-event :success)
      (sdl3:mouse-button-event
       (when (and (slot-value ev 'sdl3:%down)
                  (= (slot-value ev 'sdl3:%button) +button-right+))
         (let ((menu-x (round (slot-value ev 'sdl3:%x)))
           (menu-y (round (slot-value ev 'sdl3:%y))))
           (unless (sdl3:show-window-system-menu *window-system* menu-x menu-y)
             (format t "show-window-system-menu failed: ~a~%" (sdl3:get-error)))))
       :continue)
      (t :continue))))

(sdl3:def-app-quit system-menu-quit (result)
  (declare (ignore result))
      (sdl3:destroy-renderer *renderer-system*)
      (sdl3:destroy-window *window-system*)
  (sdl3:pump-events)
  (sdl3:quit-sub-system :video)
  (sdl3:quit))

(defun do-system-menu-demo ()
  (sdl3:enter-app-main-callbacks
   'system-menu-init
   'system-menu-iterate
   'system-menu-event
   'system-menu-quit))
