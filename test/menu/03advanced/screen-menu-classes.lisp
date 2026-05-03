(in-package :sdl3.demo.menu)

(defparameter *window-screen-menu-classes* nil)
(defparameter *renderer-screen-menu-classes* nil)
(defparameter *menu-bar-demo* nil)
(defparameter *status-message-classes*
  "Class-based menu demo. Click File/Edit/Help.")

(defconstant +mouse-button-left+ 1)

(defun make-demo-menu-bar ()
  (let* ((recent-submenu
           (make-instance 'sdl3.gui.menu.model:dropdown-menu
                          :title "Recent"
                          :entries (list
                                    (make-instance 'sdl3.gui.menu.model:command-entry
                                                   :label "alpha.txt" :hotkey ""
                                                   :action :recent-alpha)
                                    (make-instance 'sdl3.gui.menu.model:command-entry
                                                   :label "beta.txt" :hotkey ""
                                                   :action :recent-beta)
                                    (make-instance 'sdl3.gui.menu.model:separator-entry)
                                    (make-instance 'sdl3.gui.menu.model:command-entry
                                                   :label "Clear Recent" :hotkey ""
                                                   :action :clear-recent))))
         (file-menu
           (make-instance 'sdl3.gui.menu.model:dropdown-menu
                          :title "File"
                          :entries (list
                                    (make-instance 'sdl3.gui.menu.model:command-entry
                                                   :label "New" :hotkey "Ctrl+N"
                                                   :action :new)
                                    (make-instance 'sdl3.gui.menu.model:command-entry
                                                   :label "Open" :hotkey "Ctrl+O"
                                                   :action :open)
                                    (make-instance 'sdl3.gui.menu.model:separator-entry)
                                    (make-instance 'sdl3.gui.menu.model:submenu-entry
                                                   :label "Recent"
                                                   :submenu recent-submenu)
                                    (make-instance 'sdl3.gui.menu.model:separator-entry)
                                    (make-instance 'sdl3.gui.menu.model:command-entry
                                                   :label "Quit" :hotkey "Ctrl+Q"
                                                   :action :quit))))
         (edit-menu
           (make-instance 'sdl3.gui.menu.model:dropdown-menu
                          :title "Edit"
                          :entries (list
                                    (make-instance 'sdl3.gui.menu.model:command-entry
                                                   :label "Undo" :hotkey "Ctrl+Z"
                                                   :action :undo)
                                    (make-instance 'sdl3.gui.menu.model:command-entry
                                                   :label "Redo" :hotkey "Ctrl+Y"
                                                   :action :redo)
                                    (make-instance 'sdl3.gui.menu.model:separator-entry)
                                    (make-instance 'sdl3.gui.menu.model:command-entry
                                                   :label "Preferences" :hotkey ""
                                                   :action :preferences))))
         (help-menu
           (make-instance 'sdl3.gui.menu.model:dropdown-menu
                          :title "Help"
                          :entries (list
                                    (make-instance 'sdl3.gui.menu.model:command-entry
                                                   :label "Documentation" :hotkey "F1"
                                                   :action :docs)
                                    (make-instance 'sdl3.gui.menu.model:separator-entry)
                                    (make-instance 'sdl3.gui.menu.model:command-entry
                                                   :label "About" :hotkey ""
                                                   :action :about))))
         (bar (make-instance 'sdl3.gui.menu.model:menu-bar
                             :menus (list file-menu edit-menu help-menu)
                             :left 0 :top 0 :width 760
                             :height sdl3.gui.menu.model:+menu-bar-height+)))
    (sdl3.gui.menu.model:layout-menu-bar bar)
    bar))

(sdl3:def-app-init screen-menu-classes-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example Screen Menu Classes" "1.0"
                         "com.example.menu.screen.classes")
  (when (not (sdl3:init :video))
    (format t "~a~%" (sdl3:get-error))
    (return-from screen-menu-classes-init :failure))
  (multiple-value-bind (ok window renderer)
      (sdl3:create-window-and-renderer "Screen Menu - Class Based" 760 520 0)
    (if (not ok)
        (progn
          (format t "~a~%" (sdl3:get-error))
          (return-from screen-menu-classes-init :failure))
        (setf *window-screen-menu-classes* window
              *renderer-screen-menu-classes* renderer
              *menu-bar-demo* (make-demo-menu-bar)
              *status-message-classes*
              "Class-based menu demo. Click File/Edit/Help.")))
  :continue)

(sdl3:def-app-iterate screen-menu-classes-iterate ()
  (sdl3:set-render-draw-color *renderer-screen-menu-classes* 244 239 228 255)
  (sdl3:render-clear *renderer-screen-menu-classes*)

  (sdl3:set-render-draw-color *renderer-screen-menu-classes* 52 52 52 255)
  (sdl3.gui.menu.sdl3-renderer:render-debug-text
   *renderer-screen-menu-classes*
   24.0 82.0
   "Third menu demo: class model with command/separator/submenu.")
  (sdl3.gui.menu.sdl3-renderer:render-debug-text
   *renderer-screen-menu-classes*
   24.0 106.0
   "Dropdown widths are computed from visible text + paddings.")
  (sdl3.gui.menu.sdl3-renderer:render-debug-text
   *renderer-screen-menu-classes*
   24.0 150.0
   *status-message-classes*)

  (sdl3.gui.menu.sdl3-renderer:draw-menu-bar
   *renderer-screen-menu-classes*
   *menu-bar-demo*)

  (sdl3:render-present *renderer-screen-menu-classes*)
  :continue)

(sdl3:def-app-event screen-menu-classes-event (type event)
  (declare (ignore type))
  (let ((ev (sdl3:event-unmarshal event)))
    (typecase ev
      (sdl3:quit-event
       :success)
      (sdl3:mouse-motion-event
       (sdl3.gui.menu.controller:handle-mouse-motion
        *menu-bar-demo*
        (round (slot-value ev 'sdl3:%x))
        (round (slot-value ev 'sdl3:%y)))
       :continue)
      (sdl3:mouse-button-event
       (if (and (slot-value ev 'sdl3:%down)
                (= (slot-value ev 'sdl3:%button) +mouse-button-left+))
           (multiple-value-bind (kind action label)
               (sdl3.gui.menu.controller:handle-left-click
                *menu-bar-demo*
                (round (slot-value ev 'sdl3:%x))
                (round (slot-value ev 'sdl3:%y)))
             (if (eq kind :command)
                 (execute-command-action action label)
                 :continue))
           :continue))
      (sdl3:keyboard-event
       (when (and (slot-value ev 'sdl3:%down)
                  (not (slot-value ev 'sdl3:%repeat))
                  (eq (slot-value ev 'sdl3:%key) :escape))
         (if (sdl3.gui.menu.model:bar-open-menu-index *menu-bar-demo*)
             (sdl3.gui.menu.model:close-menu *menu-bar-demo*)
             (return-from screen-menu-classes-event :success)))
       :continue)
      (t
       :continue))))

(sdl3:def-app-quit screen-menu-classes-quit (result)
  (declare (ignore result))
  (sdl3:destroy-renderer *renderer-screen-menu-classes*)
  (sdl3:destroy-window *window-screen-menu-classes*)
  (sdl3:pump-events)
  (sdl3:quit-sub-system :video)
  (sdl3:quit))

(defun do-screen-menu-classes-demo ()
  (sdl3:enter-app-main-callbacks
   'screen-menu-classes-init
   'screen-menu-classes-iterate
   'screen-menu-classes-event
   'screen-menu-classes-quit))
