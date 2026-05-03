(in-package :sdl3.gui.menu)

;;;; Layout constants

(defconstant +font-char-width+          8)
(defconstant +font-text-height+         8)
(defconstant +menu-bar-height+         30)
(defconstant +menu-title-pad-x+        16)
(defconstant +menu-title-gap+           4)
(defconstant +menu-item-pad-x+         12)
(defconstant +menu-item-pad-y+          8)
(defconstant +menu-item-gap-label-hotkey+ 26)
(defconstant +submenu-arrow-width+     12)
(defconstant +separator-height+        12)
(defconstant +submenu-min-width+      140)

;;;; Entry types

(defclass menu-entry ()
  ((label :initarg :label :initform "" :accessor entry-label)))

(defclass command-entry (menu-entry)
  ((hotkey :initarg :hotkey :initform "" :accessor entry-hotkey)
   (action :initarg :action :initform :none :accessor entry-action)))

(defclass separator-entry (menu-entry) ())

(defclass submenu-entry (menu-entry)
  ((submenu :initarg :submenu :accessor entry-submenu)))

;;;; Menu structures

(defclass dropdown-menu ()
  ((title        :initarg :title   :accessor menu-title)
   (entries      :initarg :entries :accessor menu-entries)
   (left         :initform 0       :accessor menu-left)
   (top          :initform 0       :accessor menu-top)
   (title-width  :initform 0       :accessor menu-title-width)
   (panel-width  :initform 0       :accessor menu-panel-width)
   (panel-height :initform 0       :accessor menu-panel-height)))

(defclass menu-bar ()
  ((menus                   :initarg :menus              :accessor bar-menus)
   (left                    :initarg :left   :initform 0 :accessor bar-left)
   (top                     :initarg :top    :initform 0 :accessor bar-top)
   (width                   :initarg :width  :initform 760 :accessor bar-width)
   (height                  :initarg :height :initform +menu-bar-height+ :accessor bar-height)
   (open-menu-index         :initform nil    :accessor bar-open-menu-index)
   (hover-menu-index        :initform nil    :accessor bar-hover-menu-index)
   (hover-item-index        :initform nil    :accessor bar-hover-item-index)
   (open-submenu-entry-index :initform nil   :accessor bar-open-submenu-entry-index)
   (hover-sub-item-index    :initform nil    :accessor bar-hover-sub-item-index)))

;;;; Geometry helpers

(defun text-width (text)
  (* (length text) +font-char-width+))

(defun entry-row-height (entry)
  (if (typep entry 'separator-entry)
      +separator-height+
      (+ (* 2 +menu-item-pad-y+) +font-text-height+)))

(defun command-entry-content-width (entry)
  (let* ((label-w  (text-width (entry-label entry)))
         (hotkey   (entry-hotkey entry))
         (hotkey-w (if (plusp (length hotkey)) (text-width hotkey) 0))
         (gap-w    (if (> hotkey-w 0) +menu-item-gap-label-hotkey+ 0)))
    (+ label-w gap-w hotkey-w)))

(defun submenu-entry-content-width (entry)
  (+ (text-width (entry-label entry)) +submenu-arrow-width+))

(defun entry-content-width (entry)
  (cond ((typep entry 'command-entry)  (command-entry-content-width entry))
        ((typep entry 'submenu-entry)  (submenu-entry-content-width entry))
        ((typep entry 'separator-entry) 0)
        (t (text-width (entry-label entry)))))

(defun dropdown-panel-width (menu)
  (let ((content-max 0))
    (dolist (entry (menu-entries menu))
      (setf content-max (max content-max (entry-content-width entry))))
    (max +submenu-min-width+
         (+ (* 2 +menu-item-pad-x+) content-max))))

(defun dropdown-panel-height (menu)
  (let ((h 0))
    (dolist (entry (menu-entries menu))
      (incf h (entry-row-height entry)))
    h))

;;;; Layout

(defun layout-dropdown-recursive (menu)
  (setf (menu-title-width menu)
        (+ (* 2 +menu-title-pad-x+) (text-width (menu-title menu)))
        (menu-panel-width menu)  (dropdown-panel-width menu)
        (menu-panel-height menu) (dropdown-panel-height menu))
  (dolist (entry (menu-entries menu))
    (when (typep entry 'submenu-entry)
      (layout-dropdown-recursive (entry-submenu entry)))))

(defun layout-menu-bar (bar)
  (let ((cursor (bar-left bar)))
    (loop for menu in (bar-menus bar)
          do (layout-dropdown-recursive menu)
             (setf (menu-left menu) cursor
                   (menu-top  menu) (bar-top bar))
             (incf cursor (+ (menu-title-width menu) +menu-title-gap+)))))

;;;; Hit testing

(defun menu-rect-hit-p (x y left top width height)
  (and (>= x left) (< x (+ left width))
       (>= y top)  (< y (+ top height))))

(defun title-menu-index-at (bar x y)
  (loop for menu in (bar-menus bar)
        for index from 0
        when (menu-rect-hit-p x y
                              (menu-left menu) (menu-top menu)
                              (menu-title-width menu) (bar-height bar))
          do (return index)
        finally (return nil)))

(defun dropdown-item-index-at (menu panel-left panel-top x y)
  (when (menu-rect-hit-p x y panel-left panel-top
                         (menu-panel-width menu) (menu-panel-height menu))
    (let ((cursor-y panel-top))
      (loop for entry in (menu-entries menu)
            for index from 0
            for row-h = (entry-row-height entry)
            do (when (menu-rect-hit-p x y panel-left cursor-y
                                     (menu-panel-width menu) row-h)
                 (return-from dropdown-item-index-at index))
               (incf cursor-y row-h))
      nil)))

(defun submenu-panel-origin (parent-menu parent-panel-left parent-panel-top parent-entry-index)
  "Return (values sub-left sub-top) — top-left corner of the nested panel."
  (let ((cursor-y parent-panel-top))
    (loop for entry in (menu-entries parent-menu)
          for index from 0
          do (when (= index parent-entry-index)
               (return (values (+ parent-panel-left (menu-panel-width parent-menu) -1)
                               cursor-y)))
             (incf cursor-y (entry-row-height entry)))))

;;;; Open / close state

(defun open-menu (bar menu-index)
  (setf (bar-open-menu-index bar)          menu-index
        (bar-hover-item-index bar)         nil
        (bar-open-submenu-entry-index bar) nil
        (bar-hover-sub-item-index bar)     nil))

(defun close-menu (bar)
  (setf (bar-open-menu-index bar)          nil
        (bar-hover-item-index bar)         nil
        (bar-open-submenu-entry-index bar) nil
        (bar-hover-sub-item-index bar)     nil))
