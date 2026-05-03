(in-package :sdl3.demo.menu)

(defparameter *window-screen-menu-classes*  nil)
(defparameter *renderer-screen-menu-classes* nil)
(defparameter *menu-bar-demo*               nil)
(defparameter *status-message-classes*
  "Class-based menu demo. Click File/Edit/Help.")

(defconstant +mouse-button-left+ 1)

;;;; SDL rendering helpers

(defun make-menu-rect-classes (x y w h)
  (make-instance 'sdl3:rect
                 :%x (float x 1.0) :%y (float y 1.0)
                 :%w (float w 1.0) :%h (float h 1.0)))

(defun fill-menu-rect-classes (renderer x y w h red green blue)
  (sdl3:set-render-draw-color renderer red green blue 255)
  (sdl3:render-fill-rect renderer (make-menu-rect-classes x y w h)))

(defun stroke-menu-rect-classes (renderer x y w h red green blue)
  (sdl3:set-render-draw-color renderer red green blue 255)
  (sdl3:render-rect renderer (make-menu-rect-classes x y w h)))

(defun line-menu (renderer x1 y1 x2 y2 red green blue)
  (sdl3:set-render-draw-color renderer red green blue 255)
  (sdl3:render-line renderer
                    (float x1 1.0) (float y1 1.0)
                    (float x2 1.0) (float y2 1.0)))

(defun render-debug-text-classes (renderer x y text)
  (sdl3:render-debug-text renderer (float x 1.0) (float y 1.0) text))

;;;; Drawing

(defun draw-dropdown-panel (renderer menu panel-left panel-top hover-index)
  (fill-menu-rect-classes renderer panel-left panel-top
                          (gui.menu:menu-panel-width menu)
                          (gui.menu:menu-panel-height menu)
                          255 252 245)
  (stroke-menu-rect-classes renderer panel-left panel-top
                             (gui.menu:menu-panel-width menu)
                             (gui.menu:menu-panel-height menu)
                             120 105 88)
  (let ((cursor-y panel-top))
    (loop for entry in (gui.menu:menu-entries menu)
          for index from 0
          for row-h = (gui.menu:entry-row-height entry)
          do (progn
               (cond
                 ((typep entry 'gui.menu:separator-entry)
                  (line-menu renderer
                             (+ panel-left gui.menu:+menu-item-pad-x+)
                             (+ cursor-y (floor row-h 2))
                             (- (+ panel-left (gui.menu:menu-panel-width menu))
                                gui.menu:+menu-item-pad-x+)
                             (+ cursor-y (floor row-h 2))
                             170 160 145))
                 (t
                  (when (eql index hover-index)
                    (fill-menu-rect-classes renderer
                                           panel-left cursor-y
                                           (gui.menu:menu-panel-width menu) row-h
                                           186 221 198))
                  (sdl3:set-render-draw-color renderer 35 35 35 255)
                  (render-debug-text-classes renderer
                                            (+ panel-left gui.menu:+menu-item-pad-x+)
                                            (+ cursor-y gui.menu:+menu-item-pad-y+)
                                            (gui.menu:entry-label entry))
                  (cond
                    ((typep entry 'gui.menu:command-entry)
                     (let* ((hotkey   (gui.menu:entry-hotkey entry))
                            (hotkey-w (gui.menu:text-width hotkey))
                            (hotkey-x (- (+ panel-left (gui.menu:menu-panel-width menu))
                                         gui.menu:+menu-item-pad-x+
                                         hotkey-w)))
                       (when (plusp (length hotkey))
                         (sdl3:set-render-draw-color renderer 102 102 102 255)
                         (render-debug-text-classes renderer
                                                    hotkey-x
                                                    (+ cursor-y gui.menu:+menu-item-pad-y+)
                                                    hotkey))))
                    ((typep entry 'gui.menu:submenu-entry)
                     (sdl3:set-render-draw-color renderer 102 102 102 255)
                     (render-debug-text-classes renderer
                                               (- (+ panel-left
                                                     (gui.menu:menu-panel-width menu))
                                                  gui.menu:+menu-item-pad-x+
                                                  gui.menu:+submenu-arrow-width+)
                                               (+ cursor-y gui.menu:+menu-item-pad-y+)
                                               ">")))))
               (incf cursor-y row-h)))))

(defun draw-menu-bar (renderer bar)
  (fill-menu-rect-classes renderer
                          (gui.menu:bar-left bar) (gui.menu:bar-top bar)
                          (gui.menu:bar-width bar) (gui.menu:bar-height bar)
                          214 205 190)
  (stroke-menu-rect-classes renderer
                             (gui.menu:bar-left bar) (gui.menu:bar-top bar)
                             (gui.menu:bar-width bar) (gui.menu:bar-height bar)
                             120 105 88)
  (loop for menu in (gui.menu:bar-menus bar)
        for index from 0
        do (when (or (eql index (gui.menu:bar-open-menu-index bar))
                     (eql index (gui.menu:bar-hover-menu-index bar)))
             (fill-menu-rect-classes renderer
                                     (gui.menu:menu-left menu)
                                     (gui.menu:menu-top menu)
                                     (gui.menu:menu-title-width menu)
                                     (gui.menu:bar-height bar)
                                     166 201 186))
           (stroke-menu-rect-classes renderer
                                     (gui.menu:menu-left menu)
                                     (gui.menu:menu-top menu)
                                     (gui.menu:menu-title-width menu)
                                     (gui.menu:bar-height bar)
                                     120 105 88)
           (sdl3:set-render-draw-color renderer 35 35 35 255)
           (render-debug-text-classes renderer
                                      (+ (gui.menu:menu-left menu)
                                         gui.menu:+menu-title-pad-x+)
                                      (+ (gui.menu:bar-top bar) 10)
                                      (gui.menu:menu-title menu)))
  (let ((open-index (gui.menu:bar-open-menu-index bar)))
    (when open-index
      (let* ((menu       (nth open-index (gui.menu:bar-menus bar)))
             (panel-left (gui.menu:menu-left menu))
             (panel-top  (+ (gui.menu:bar-top bar) (gui.menu:bar-height bar))))
        (draw-dropdown-panel renderer menu panel-left panel-top
                             (gui.menu:bar-hover-item-index bar))
        (let ((sub-entry-index (gui.menu:bar-open-submenu-entry-index bar)))
          (when sub-entry-index
            (let ((entry (nth sub-entry-index (gui.menu:menu-entries menu))))
              (when (typep entry 'gui.menu:submenu-entry)
                (multiple-value-bind (sub-left sub-top)
                    (gui.menu:submenu-panel-origin menu panel-left panel-top sub-entry-index)
                  (draw-dropdown-panel renderer
                                       (gui.menu:entry-submenu entry)
                                       sub-left sub-top
                                       (gui.menu:bar-hover-sub-item-index bar)))))))))))

;;;; Application logic

(defun execute-command-action (action label)
  (setf *status-message-classes* (format nil "Action: ~a" label))
  (format t "screen menu class action: ~a (~a)~%" label action)
  (if (eq action :quit) :success :continue))

(defun process-dropdown-click (bar x y)
  (let* ((menu       (nth (gui.menu:bar-open-menu-index bar) (gui.menu:bar-menus bar)))
         (panel-left (gui.menu:menu-left menu))
         (panel-top  (+ (gui.menu:bar-top bar) (gui.menu:bar-height bar)))
         (item-index (gui.menu:dropdown-item-index-at menu panel-left panel-top x y)))
    (when item-index
      (let ((entry (nth item-index (gui.menu:menu-entries menu))))
        (cond
          ((typep entry 'gui.menu:separator-entry)  :continue)
          ((typep entry 'gui.menu:submenu-entry)
           (setf (gui.menu:bar-open-submenu-entry-index bar) item-index
                 (gui.menu:bar-hover-sub-item-index bar) nil)
           :continue)
          ((typep entry 'gui.menu:command-entry)
           (gui.menu:close-menu bar)
           (execute-command-action (gui.menu:entry-action entry)
                                   (gui.menu:entry-label entry)))
          (t :continue))))))

(defun process-submenu-click (bar x y)
  (let* ((open-index      (gui.menu:bar-open-menu-index bar))
         (menu            (and open-index (nth open-index (gui.menu:bar-menus bar))))
         (sub-entry-index (gui.menu:bar-open-submenu-entry-index bar)))
    (when (and menu sub-entry-index)
      (let ((entry (nth sub-entry-index (gui.menu:menu-entries menu))))
        (when (typep entry 'gui.menu:submenu-entry)
          (let* ((panel-left (gui.menu:menu-left menu))
                 (panel-top  (+ (gui.menu:bar-top bar) (gui.menu:bar-height bar))))
            (multiple-value-bind (sub-left sub-top)
                (gui.menu:submenu-panel-origin menu panel-left panel-top sub-entry-index)
              (let* ((sub-menu  (gui.menu:entry-submenu entry))
                     (sub-index (gui.menu:dropdown-item-index-at sub-menu
                                                                 sub-left sub-top x y)))
                (when sub-index
                  (let ((sub-entry (nth sub-index (gui.menu:menu-entries sub-menu))))
                    (when (typep sub-entry 'gui.menu:command-entry)
                      (gui.menu:close-menu bar)
                      (return-from process-submenu-click
                        (execute-command-action (gui.menu:entry-action sub-entry)
                                                (gui.menu:entry-label sub-entry)))))))))))
  nil)))

(defun process-mouse-motion (bar x y)
  (let ((title-index (gui.menu:title-menu-index-at bar x y)))
    (setf (gui.menu:bar-hover-menu-index bar) title-index)
    (when (and (gui.menu:bar-open-menu-index bar) title-index)
      (unless (eql title-index (gui.menu:bar-open-menu-index bar))
        (gui.menu:open-menu bar title-index)))
    (let ((open-index (gui.menu:bar-open-menu-index bar)))
      (when open-index
        (let* ((menu       (nth open-index (gui.menu:bar-menus bar)))
               (panel-left (gui.menu:menu-left menu))
               (panel-top  (+ (gui.menu:bar-top bar) (gui.menu:bar-height bar)))
               (item-index (gui.menu:dropdown-item-index-at menu panel-left panel-top x y)))
          (setf (gui.menu:bar-hover-item-index bar) item-index)
          (cond
            ((and item-index
                  (typep (nth item-index (gui.menu:menu-entries menu))
                         'gui.menu:submenu-entry))
             (setf (gui.menu:bar-open-submenu-entry-index bar) item-index)
             (multiple-value-bind (sub-left sub-top)
                 (gui.menu:submenu-panel-origin menu panel-left panel-top item-index)
               (let* ((sub-menu  (gui.menu:entry-submenu
                                  (nth item-index (gui.menu:menu-entries menu))))
                      (sub-index (gui.menu:dropdown-item-index-at
                                  sub-menu sub-left sub-top x y)))
                 (setf (gui.menu:bar-hover-sub-item-index bar) sub-index))))
            ((gui.menu:bar-open-submenu-entry-index bar)
             (multiple-value-bind (sub-left sub-top)
                 (gui.menu:submenu-panel-origin menu panel-left panel-top
                                               (gui.menu:bar-open-submenu-entry-index bar))
               (let* ((sub-menu  (gui.menu:entry-submenu
                                  (nth (gui.menu:bar-open-submenu-entry-index bar)
                                       (gui.menu:menu-entries menu))))
                      (sub-index (gui.menu:dropdown-item-index-at
                                  sub-menu sub-left sub-top x y)))
                 (setf (gui.menu:bar-hover-sub-item-index bar) sub-index)
                 (unless sub-index
                   (setf (gui.menu:bar-open-submenu-entry-index bar) nil
                         (gui.menu:bar-hover-sub-item-index bar) nil)))))
            (t
             (setf (gui.menu:bar-open-submenu-entry-index bar) nil
                   (gui.menu:bar-hover-sub-item-index bar) nil))))))))

;;;; Demo menu setup

(defun make-demo-menu-bar ()
  (let* ((recent-submenu
           (make-instance 'gui.menu:dropdown-menu
                          :title "Recent"
                          :entries (list
                                    (make-instance 'gui.menu:command-entry
                                                   :label "alpha.txt" :hotkey ""
                                                   :action :recent-alpha)
                                    (make-instance 'gui.menu:command-entry
                                                   :label "beta.txt" :hotkey ""
                                                   :action :recent-beta)
                                    (make-instance 'gui.menu:separator-entry)
                                    (make-instance 'gui.menu:command-entry
                                                   :label "Clear Recent" :hotkey ""
                                                   :action :clear-recent))))
         (file-menu
           (make-instance 'gui.menu:dropdown-menu
                          :title "File"
                          :entries (list
                                    (make-instance 'gui.menu:command-entry
                                                   :label "New" :hotkey "Ctrl+N"
                                                   :action :new)
                                    (make-instance 'gui.menu:command-entry
                                                   :label "Open" :hotkey "Ctrl+O"
                                                   :action :open)
                                    (make-instance 'gui.menu:separator-entry)
                                    (make-instance 'gui.menu:submenu-entry
                                                   :label "Recent"
                                                   :submenu recent-submenu)
                                    (make-instance 'gui.menu:separator-entry)
                                    (make-instance 'gui.menu:command-entry
                                                   :label "Quit" :hotkey "Ctrl+Q"
                                                   :action :quit))))
         (edit-menu
           (make-instance 'gui.menu:dropdown-menu
                          :title "Edit"
                          :entries (list
                                    (make-instance 'gui.menu:command-entry
                                                   :label "Undo" :hotkey "Ctrl+Z"
                                                   :action :undo)
                                    (make-instance 'gui.menu:command-entry
                                                   :label "Redo" :hotkey "Ctrl+Y"
                                                   :action :redo)
                                    (make-instance 'gui.menu:separator-entry)
                                    (make-instance 'gui.menu:command-entry
                                                   :label "Preferences" :hotkey ""
                                                   :action :preferences))))
         (help-menu
           (make-instance 'gui.menu:dropdown-menu
                          :title "Help"
                          :entries (list
                                    (make-instance 'gui.menu:command-entry
                                                   :label "Documentation" :hotkey "F1"
                                                   :action :docs)
                                    (make-instance 'gui.menu:separator-entry)
                                    (make-instance 'gui.menu:command-entry
                                                   :label "About" :hotkey ""
                                                   :action :about))))
         (bar (make-instance 'gui.menu:menu-bar
                             :menus (list file-menu edit-menu help-menu)
                             :left 0 :top 0 :width 760
                             :height gui.menu:+menu-bar-height+)))
    (gui.menu:layout-menu-bar bar)
    bar))

;;;; SDL3 app callbacks

(sdl3:def-app-init screen-menu-classes-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example Screen Menu Classes" "1.0"
                         "com.example.menu.screen.classes")
  (when (not (sdl3:init :video))
    (format t "~a~%" (sdl3:get-error))
    (return-from screen-menu-classes-init :failure))
  (multiple-value-bind (ok window renderer)
      (sdl3:create-window-and-renderer "Screen Menu - Class Based" 760 420 0)
    (if (not ok)
        (progn
          (format t "~a~%" (sdl3:get-error))
          (return-from screen-menu-classes-init :failure))
        (setf *window-screen-menu-classes*  window
              *renderer-screen-menu-classes* renderer
              *menu-bar-demo*               (make-demo-menu-bar)
              *status-message-classes*
              "Class-based menu demo. Click File/Edit/Help.")))
  :continue)

(sdl3:def-app-iterate screen-menu-classes-iterate ()
  (sdl3:set-render-draw-color *renderer-screen-menu-classes* 244 239 228 255)
  (sdl3:render-clear *renderer-screen-menu-classes*)

  (sdl3:set-render-draw-color *renderer-screen-menu-classes* 52 52 52 255)
  (render-debug-text-classes *renderer-screen-menu-classes*
                             24.0 82.0
                             "Third menu demo: class model with command/separator/submenu.")
  (render-debug-text-classes *renderer-screen-menu-classes*
                             24.0 106.0
                             "Dropdown widths are computed from visible text + paddings.")
  (render-debug-text-classes *renderer-screen-menu-classes*
                             24.0 150.0
                             *status-message-classes*)

  (draw-menu-bar *renderer-screen-menu-classes* *menu-bar-demo*)

  (sdl3:render-present *renderer-screen-menu-classes*)
  :continue)

(sdl3:def-app-event screen-menu-classes-event (type event)
  (declare (ignore type))
  (let ((ev (sdl3:event-unmarshal event)))
    (typecase ev
      (sdl3:quit-event :success)
      (sdl3:mouse-motion-event
       (process-mouse-motion *menu-bar-demo*
                             (round (slot-value ev 'sdl3:%x))
                             (round (slot-value ev 'sdl3:%y)))
       :continue)
      (sdl3:mouse-button-event
       (if (and (slot-value ev 'sdl3:%down)
                (= (slot-value ev 'sdl3:%button) +mouse-button-left+))
           (let* ((x           (round (slot-value ev 'sdl3:%x)))
                  (y           (round (slot-value ev 'sdl3:%y)))
                  (title-index (gui.menu:title-menu-index-at *menu-bar-demo* x y))
                  (open-index  (gui.menu:bar-open-menu-index *menu-bar-demo*)))
             (cond
               (title-index
                (if (eql title-index open-index)
                    (gui.menu:close-menu *menu-bar-demo*)
                    (gui.menu:open-menu  *menu-bar-demo* title-index))
                :continue)
               (open-index
                (or (process-submenu-click *menu-bar-demo* x y)
                    (process-dropdown-click *menu-bar-demo* x y)
                    (progn
                      (gui.menu:close-menu *menu-bar-demo*)
                      :continue)))
               (t :continue)))
           :continue))
      (sdl3:keyboard-event
       (when (and (slot-value ev 'sdl3:%down)
                  (not (slot-value ev 'sdl3:%repeat))
                  (eq (slot-value ev 'sdl3:%key) :escape))
         (if (gui.menu:bar-open-menu-index *menu-bar-demo*)
             (gui.menu:close-menu *menu-bar-demo*)
             (return-from screen-menu-classes-event :success)))
       :continue)
      (t :continue))))

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
