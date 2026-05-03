(in-package :sdl3.gui.menu.controller)

(defun process-dropdown-click (bar x y)
  (let* ((menu       (nth (sdl3.gui.menu.model:bar-open-menu-index bar)
                          (sdl3.gui.menu.model:bar-menus bar)))
         (panel-left (sdl3.gui.menu.model:menu-left menu))
         (panel-top  (+ (sdl3.gui.menu.model:bar-top bar)
                        (sdl3.gui.menu.model:bar-height bar)))
         (item-index (sdl3.gui.menu.model:dropdown-item-index-at
                      menu panel-left panel-top x y)))
    (if (null item-index)
        (values :miss nil nil)
        (let ((entry (nth item-index (sdl3.gui.menu.model:menu-entries menu))))
          (cond
            ((typep entry 'sdl3.gui.menu.model:separator-entry)
             (values :continue nil nil))
            ((typep entry 'sdl3.gui.menu.model:submenu-entry)
             (setf (sdl3.gui.menu.model:bar-open-submenu-entry-index bar) item-index
                   (sdl3.gui.menu.model:bar-hover-sub-item-index bar) nil)
             (values :continue nil nil))
            ((typep entry 'sdl3.gui.menu.model:command-entry)
             (sdl3.gui.menu.model:close-menu bar)
             (values :command
                     (sdl3.gui.menu.model:entry-action entry)
                     (sdl3.gui.menu.model:entry-label entry)))
            (t
             (values :continue nil nil)))))))

(defun process-submenu-click (bar x y)
  (let* ((open-index      (sdl3.gui.menu.model:bar-open-menu-index bar))
         (menu            (and open-index (nth open-index (sdl3.gui.menu.model:bar-menus bar))))
         (sub-entry-index (sdl3.gui.menu.model:bar-open-submenu-entry-index bar)))
    (if (not (and menu sub-entry-index))
        (values :miss nil nil)
        (let ((entry (nth sub-entry-index (sdl3.gui.menu.model:menu-entries menu))))
          (if (not (typep entry 'sdl3.gui.menu.model:submenu-entry))
              (values :miss nil nil)
              (let* ((panel-left (sdl3.gui.menu.model:menu-left menu))
                     (panel-top  (+ (sdl3.gui.menu.model:bar-top bar)
                                    (sdl3.gui.menu.model:bar-height bar))))
                (multiple-value-bind (sub-left sub-top)
                    (sdl3.gui.menu.model:submenu-panel-origin
                     menu panel-left panel-top sub-entry-index)
                  (let* ((sub-menu  (sdl3.gui.menu.model:entry-submenu entry))
                         (sub-index (sdl3.gui.menu.model:dropdown-item-index-at
                                     sub-menu sub-left sub-top x y)))
                    (if (null sub-index)
                        (values :miss nil nil)
                        (let ((sub-entry (nth sub-index
                                              (sdl3.gui.menu.model:menu-entries sub-menu))))
                          (if (typep sub-entry 'sdl3.gui.menu.model:command-entry)
                              (progn
                                (sdl3.gui.menu.model:close-menu bar)
                                (values :command
                                        (sdl3.gui.menu.model:entry-action sub-entry)
                                        (sdl3.gui.menu.model:entry-label sub-entry)))
                              (values :continue nil nil))))))))))))

(defun handle-left-click (bar x y)
  (let ((title-index (sdl3.gui.menu.model:title-menu-index-at bar x y))
        (open-index  (sdl3.gui.menu.model:bar-open-menu-index bar)))
    (cond
      (title-index
       (if (eql title-index open-index)
           (sdl3.gui.menu.model:close-menu bar)
           (sdl3.gui.menu.model:open-menu bar title-index))
       (values :continue nil nil))
      (open-index
       (multiple-value-bind (kind action label)
           (process-submenu-click bar x y)
         (if (eq kind :miss)
             (multiple-value-bind (kind2 action2 label2)
                 (process-dropdown-click bar x y)
               (if (eq kind2 :miss)
                   (progn
                     (sdl3.gui.menu.model:close-menu bar)
                     (values :continue nil nil))
                   (values kind2 action2 label2)))
             (values kind action label))))
      (t
       (values :continue nil nil)))))

(defun handle-mouse-motion (bar x y)
  (let ((title-index (sdl3.gui.menu.model:title-menu-index-at bar x y)))
    (setf (sdl3.gui.menu.model:bar-hover-menu-index bar) title-index)
    (when (and (sdl3.gui.menu.model:bar-open-menu-index bar) title-index)
      (unless (eql title-index (sdl3.gui.menu.model:bar-open-menu-index bar))
        (sdl3.gui.menu.model:open-menu bar title-index)))
    (let ((open-index (sdl3.gui.menu.model:bar-open-menu-index bar)))
      (when open-index
        (let* ((menu       (nth open-index (sdl3.gui.menu.model:bar-menus bar)))
               (panel-left (sdl3.gui.menu.model:menu-left menu))
               (panel-top  (+ (sdl3.gui.menu.model:bar-top bar)
                              (sdl3.gui.menu.model:bar-height bar)))
               (item-index (sdl3.gui.menu.model:dropdown-item-index-at
                            menu panel-left panel-top x y)))
          (setf (sdl3.gui.menu.model:bar-hover-item-index bar) item-index)
          (cond
            ((and item-index
                  (typep (nth item-index (sdl3.gui.menu.model:menu-entries menu))
                         'sdl3.gui.menu.model:submenu-entry))
             (setf (sdl3.gui.menu.model:bar-open-submenu-entry-index bar) item-index)
             (multiple-value-bind (sub-left sub-top)
                 (sdl3.gui.menu.model:submenu-panel-origin
                  menu panel-left panel-top item-index)
               (let* ((sub-menu  (sdl3.gui.menu.model:entry-submenu
                                  (nth item-index (sdl3.gui.menu.model:menu-entries menu))))
                      (sub-index (sdl3.gui.menu.model:dropdown-item-index-at
                                  sub-menu sub-left sub-top x y)))
                 (setf (sdl3.gui.menu.model:bar-hover-sub-item-index bar) sub-index))))
            ((sdl3.gui.menu.model:bar-open-submenu-entry-index bar)
             (multiple-value-bind (sub-left sub-top)
                 (sdl3.gui.menu.model:submenu-panel-origin
                  menu panel-left panel-top
                  (sdl3.gui.menu.model:bar-open-submenu-entry-index bar))
               (let* ((sub-menu  (sdl3.gui.menu.model:entry-submenu
                                  (nth (sdl3.gui.menu.model:bar-open-submenu-entry-index bar)
                                       (sdl3.gui.menu.model:menu-entries menu))))
                      (sub-index (sdl3.gui.menu.model:dropdown-item-index-at
                                  sub-menu sub-left sub-top x y)))
                 (setf (sdl3.gui.menu.model:bar-hover-sub-item-index bar) sub-index)
                 (unless sub-index
                   (setf (sdl3.gui.menu.model:bar-open-submenu-entry-index bar) nil
                         (sdl3.gui.menu.model:bar-hover-sub-item-index bar) nil)))))
            (t
             (setf (sdl3.gui.menu.model:bar-open-submenu-entry-index bar) nil
                   (sdl3.gui.menu.model:bar-hover-sub-item-index bar) nil))))))))
