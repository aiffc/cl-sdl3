(in-package :sdl3.demo.menu)

(defparameter *window-screen-menu* nil)
(defparameter *renderer-screen-menu* nil)
(defparameter *open-menu-index* nil)
(defparameter *hover-menu-index* nil)
(defparameter *hover-item-index* nil)
(defparameter *status-message* "Click File, Edit or Help.")

;; Each item: (label hotkey-display hotkey-mod hotkey-key)
;; hotkey-mod is :ctrl or nil; hotkey-key is an SDL keycode keyword or nil.
(defparameter *screen-menu-model*
  '((:file "File"
     ("Open"       "Ctrl+O" :ctrl :o)
     ("Save"       "Ctrl+S" :ctrl :s)
     ("Quit"       "Ctrl+Q" :ctrl :q))
    (:edit "Edit"
     ("Copy"       "Ctrl+C" :ctrl :c)
     ("Paste"      "Ctrl+V" :ctrl :v)
     ("Select All" "Ctrl+A" :ctrl :a))
    (:help "Help"
     ("Shortcuts"  "F1"     nil   :f1)
     ("About"      ""       nil   nil))))

(defconstant +mouse-button-left+ 1)
(defconstant +menu-bar-height+ 28)
(defconstant +menu-title-width+ 78)
(defconstant +submenu-width+ 200)
(defconstant +submenu-item-height+ 24)

(defun screen-menu-entry (index)
  (nth index *screen-menu-model*))

(defun screen-menu-title (index)
  (second (screen-menu-entry index)))

(defun screen-menu-items (index)
  (cddr (screen-menu-entry index)))

(defun item-label     (item) (first  item))
(defun item-hotkey-str (item) (second item))
(defun item-hotkey-mod (item) (third  item))
(defun item-hotkey-key (item) (fourth item))

(defun ctrl-held-p (ev)
  (let ((mods (slot-value ev 'sdl3:%mod)))
    (typecase mods
      (list    (or (member :ctrl mods) (member :lctrl mods) (member :rctrl mods)))
      (symbol  (member mods '(:ctrl :lctrl :rctrl)))
      (integer (not (zerop (logand mods #x00c0))))
      (t nil))))

(defun item-hotkey-matches-p (item ev)
  (let ((mod (item-hotkey-mod item))
        (key (item-hotkey-key item)))
    (when key
      (and (eq (slot-value ev 'sdl3:%key) key)
           (if (eq mod :ctrl)
               (ctrl-held-p ev)
               t)))))

(defun screen-menu-count ()
  (length *screen-menu-model*))

(defun rect-hit-p (x y left top width height)
  (and (>= x left)
       (< x (+ left width))
       (>= y top)
       (< y (+ top height))))

(defun title-left (index)
  (* index +menu-title-width+))

(defun submenu-item-at (x y)
  (when *open-menu-index*
    (let* ((left (title-left *open-menu-index*))
           (top +menu-bar-height+)
           (items (screen-menu-items *open-menu-index*))
           (height (* (length items) +submenu-item-height+)))
      (when (rect-hit-p x y left top +submenu-width+ height)
        (floor (- y top) +submenu-item-height+)))))

(defun menu-index-at (x y)
  (when (rect-hit-p x y 0 0 (* (screen-menu-count) +menu-title-width+) +menu-bar-height+)
    (let ((index (floor x +menu-title-width+)))
      (when (< index (screen-menu-count))
        index))))

(defun make-menu-rect (x y w h)
  (make-instance 'sdl3:rect
                 :%x (float x 1.0)
                 :%y (float y 1.0)
                 :%w (float w 1.0)
                 :%h (float h 1.0)))

(defun fill-menu-rect (renderer x y w h red green blue)
  (sdl3:set-render-draw-color renderer red green blue 255)
  (sdl3:render-fill-rect renderer (make-menu-rect x y w h)))

(defun stroke-menu-rect (renderer x y w h red green blue)
  (sdl3:set-render-draw-color renderer red green blue 255)
  (sdl3:render-rect renderer (make-menu-rect x y w h)))

(defun activate-screen-menu-item (menu-index item-index)
  (let* ((menu-title (screen-menu-title menu-index))
         (item      (nth item-index (screen-menu-items menu-index)))
         (label     (item-label item)))
    (setf *open-menu-index* nil
          *hover-item-index* nil
          *status-message* (format nil "Selected ~a / ~a" menu-title label))
    (format t "screen menu action: ~a~%" *status-message*)
    (if (and (zerop menu-index)
             (string= label "Quit"))
        :success
        :continue)))

(sdl3:def-app-init screen-menu-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example Screen Menu" "1.0" "com.example.menu.screen")
  (when (not (sdl3:init :video))
    (format t "~a~%" (sdl3:get-error))
    (return-from screen-menu-init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer
       "Screen Menu — File / Edit / Help" 720 360 0)
    (if (not rst)
        (progn
          (format t "~a~%" (sdl3:get-error))
          (return-from screen-menu-init :failure))
        (setf *window-screen-menu* window
              *renderer-screen-menu* renderer
              *open-menu-index* nil
              *hover-menu-index* nil
              *hover-item-index* nil
              *status-message* "Click File, Edit or Help.")))
  :continue)

(sdl3:def-app-iterate screen-menu-iterate ()
  (sdl3:set-render-draw-color *renderer-screen-menu* 244 239 228 255)
  (sdl3:render-clear *renderer-screen-menu*)

  (fill-menu-rect *renderer-screen-menu* 0 0 720 +menu-bar-height+ 214 205 190)
  (stroke-menu-rect *renderer-screen-menu* 0 0 720 +menu-bar-height+ 120 105 88)

  (loop for index from 0 below (screen-menu-count)
        for left = (title-left index)
        do (when (or (eql index *open-menu-index*)
                     (eql index *hover-menu-index*))
             (fill-menu-rect *renderer-screen-menu*
                             left 0 +menu-title-width+ +menu-bar-height+
                             166 201 186))
           (stroke-menu-rect *renderer-screen-menu*
                             left 0 +menu-title-width+ +menu-bar-height+
                             120 105 88)
           (sdl3:set-render-draw-color *renderer-screen-menu* 35 35 35 255)
           (sdl3:render-debug-text *renderer-screen-menu*
                                   (+ left 16.0)
                                   10.0
                                   (screen-menu-title index)))

  (sdl3:set-render-draw-color *renderer-screen-menu* 52 52 52 255)
  (sdl3:render-debug-text *renderer-screen-menu* 24.0 72.0 "On-screen menu demo")
  (sdl3:render-debug-text *renderer-screen-menu* 24.0 96.0 "File / Edit / Help are rendered by SDL.")
  (sdl3:render-debug-text *renderer-screen-menu* 24.0 120.0 "Click a title to open its menu. Hotkeys: Ctrl+O/S/Q, Ctrl+C/V/A, F1.")
  (sdl3:render-debug-text *renderer-screen-menu* 24.0 168.0 *status-message*)

  (when *open-menu-index*
    (let* ((left (title-left *open-menu-index*))
           (items (screen-menu-items *open-menu-index*))
           (panel-height (* (length items) +submenu-item-height+)))
      (fill-menu-rect *renderer-screen-menu*
                      left +menu-bar-height+ +submenu-width+ panel-height
                      255 252 245)
      (stroke-menu-rect *renderer-screen-menu*
                        left +menu-bar-height+ +submenu-width+ panel-height
                        120 105 88)
      (loop for item in items
            for item-index from 0
            for top = (+ +menu-bar-height+ (* item-index +submenu-item-height+))
            for label = (item-label item)
            for hint  = (item-hotkey-str item)
            do (when (eql item-index *hover-item-index*)
                 (fill-menu-rect *renderer-screen-menu*
                                 left top +submenu-width+ +submenu-item-height+
                                 186 221 198))
               (sdl3:set-render-draw-color *renderer-screen-menu* 35 35 35 255)
               (sdl3:render-debug-text *renderer-screen-menu*
                                       (+ left 12.0)
                                       (+ top 8.0)
                                       label)
               (when (and hint (plusp (length hint)))
                 (sdl3:set-render-draw-color *renderer-screen-menu* 100 100 100 255)
                 (sdl3:render-debug-text *renderer-screen-menu*
                                         (float (- (+ left +submenu-width+) 4
                                                   (* 8 (length hint))) 1.0)
                                         (+ top 8.0)
                                         hint)))))
  (sdl3:render-present *renderer-screen-menu*)
  :continue)

(sdl3:def-app-event screen-menu-event (type event)
  (declare (ignore type))
  (let ((ev (sdl3:event-unmarshal event)))
    (typecase ev
      (sdl3:quit-event :success)
      (sdl3:mouse-motion-event
       (let* ((mouse-x (round (slot-value ev 'sdl3:%x)))
              (mouse-y (round (slot-value ev 'sdl3:%y)))
              (menu-index (menu-index-at mouse-x mouse-y))
              (item-index (submenu-item-at mouse-x mouse-y)))
         (setf *hover-menu-index* menu-index
               *hover-item-index* item-index)
         (when (and *open-menu-index* menu-index)
           (setf *open-menu-index* menu-index
                 *hover-item-index* nil)))
       :continue)
      (sdl3:mouse-button-event
       (if (and (slot-value ev 'sdl3:%down)
                (= (slot-value ev 'sdl3:%button) +mouse-button-left+))
           (let* ((mouse-x (round (slot-value ev 'sdl3:%x)))
                  (mouse-y (round (slot-value ev 'sdl3:%y)))
                  (menu-index (menu-index-at mouse-x mouse-y))
                  (item-index (submenu-item-at mouse-x mouse-y)))
             (cond (menu-index
                    (setf *open-menu-index* (if (eql *open-menu-index* menu-index)
                                                nil
                                                menu-index)
                          *hover-menu-index* menu-index
                          *hover-item-index* nil
                          *status-message* (format nil "Opened ~a menu" (screen-menu-title menu-index)))
                    :continue)
                   (item-index
                    (activate-screen-menu-item *open-menu-index* item-index))
                   (t
                    (setf *open-menu-index* nil
                          *hover-item-index* nil)
                    :continue)))
           :continue))
      (sdl3:keyboard-event
       (when (and (slot-value ev 'sdl3:%down)
                  (not (slot-value ev 'sdl3:%repeat)))
         (cond
           ((eq (slot-value ev 'sdl3:%key) :escape)
            (if *open-menu-index*
                (setf *open-menu-index* nil
                      *hover-item-index* nil
                      *status-message* "Menu closed.")
                (return-from screen-menu-event :success)))
           (t
            (loop for menu-index from 0 below (screen-menu-count)
                  do (loop for item-index from 0
                           for item in (screen-menu-items menu-index)
                           when (item-hotkey-matches-p item ev)
                           do (return-from screen-menu-event
                                (activate-screen-menu-item menu-index item-index)))))))
       :continue)
      (t :continue))))

(sdl3:def-app-quit screen-menu-quit (result)
  (declare (ignore result))
  (sdl3:destroy-renderer *renderer-screen-menu*)
  (sdl3:destroy-window *window-screen-menu*)
  (sdl3:pump-events)
  (sdl3:quit-sub-system :video)
  (sdl3:quit))

(defun do-screen-menu-demo ()
  (sdl3:enter-app-main-callbacks
   'screen-menu-init
   'screen-menu-iterate
   'screen-menu-event
   'screen-menu-quit))