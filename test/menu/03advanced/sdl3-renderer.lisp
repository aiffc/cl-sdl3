(in-package :sdl3.gui.menu.sdl3-renderer)

(defun make-menu-rect (x y w h)
  (make-instance 'sdl3:rect
                 :%x (float x 1.0) :%y (float y 1.0)
                 :%w (float w 1.0) :%h (float h 1.0)))

(defun fill-menu-rect (renderer x y w h red green blue)
  (sdl3:set-render-draw-color renderer red green blue 255)
  (sdl3:render-fill-rect renderer (make-menu-rect x y w h)))

(defun stroke-menu-rect (renderer x y w h red green blue)
  (sdl3:set-render-draw-color renderer red green blue 255)
  (sdl3:render-rect renderer (make-menu-rect x y w h)))

(defun line-menu (renderer x1 y1 x2 y2 red green blue)
  (sdl3:set-render-draw-color renderer red green blue 255)
  (sdl3:render-line renderer
                    (float x1 1.0) (float y1 1.0)
                    (float x2 1.0) (float y2 1.0)))

(defun render-debug-text (renderer x y text)
  (sdl3:render-debug-text renderer (float x 1.0) (float y 1.0) text))

(defun draw-dropdown-panel (renderer menu panel-left panel-top hover-index)
  (fill-menu-rect renderer panel-left panel-top
                  (sdl3.gui.menu.model:menu-panel-width menu)
                  (sdl3.gui.menu.model:menu-panel-height menu)
                  255 252 245)
  (stroke-menu-rect renderer panel-left panel-top
                    (sdl3.gui.menu.model:menu-panel-width menu)
                    (sdl3.gui.menu.model:menu-panel-height menu)
                    120 105 88)
  (let ((cursor-y panel-top))
    (loop for entry in (sdl3.gui.menu.model:menu-entries menu)
          for index from 0
          for row-h = (sdl3.gui.menu.model:entry-row-height entry)
          do (progn
               (cond
                 ((typep entry 'sdl3.gui.menu.model:separator-entry)
                  (line-menu renderer
                             (+ panel-left sdl3.gui.menu.model:+menu-item-pad-x+)
                             (+ cursor-y (floor row-h 2))
                             (- (+ panel-left (sdl3.gui.menu.model:menu-panel-width menu))
                                sdl3.gui.menu.model:+menu-item-pad-x+)
                             (+ cursor-y (floor row-h 2))
                             170 160 145))
                 (t
                  (when (eql index hover-index)
                    (fill-menu-rect renderer
                                    panel-left cursor-y
                                    (sdl3.gui.menu.model:menu-panel-width menu) row-h
                                    186 221 198))
                  (sdl3:set-render-draw-color renderer 35 35 35 255)
                  (render-debug-text renderer
                                     (+ panel-left sdl3.gui.menu.model:+menu-item-pad-x+)
                                     (+ cursor-y sdl3.gui.menu.model:+menu-item-pad-y+)
                                     (sdl3.gui.menu.model:entry-label entry))
                  (cond
                    ((typep entry 'sdl3.gui.menu.model:command-entry)
                     (let* ((hotkey   (sdl3.gui.menu.model:entry-hotkey entry))
                            (hotkey-w (sdl3.gui.menu.model:text-width hotkey))
                            (hotkey-x (- (+ panel-left (sdl3.gui.menu.model:menu-panel-width menu))
                                         sdl3.gui.menu.model:+menu-item-pad-x+
                                         hotkey-w)))
                       (when (plusp (length hotkey))
                         (sdl3:set-render-draw-color renderer 102 102 102 255)
                         (render-debug-text renderer
                                            hotkey-x
                                            (+ cursor-y sdl3.gui.menu.model:+menu-item-pad-y+)
                                            hotkey))))
                    ((typep entry 'sdl3.gui.menu.model:submenu-entry)
                     (sdl3:set-render-draw-color renderer 102 102 102 255)
                     (render-debug-text renderer
                                        (- (+ panel-left
                                              (sdl3.gui.menu.model:menu-panel-width menu))
                                           sdl3.gui.menu.model:+menu-item-pad-x+
                                           sdl3.gui.menu.model:+submenu-arrow-width+)
                                        (+ cursor-y sdl3.gui.menu.model:+menu-item-pad-y+)
                                        ">")))))
               (incf cursor-y row-h)))))

(defun draw-menu-bar (renderer bar)
  (fill-menu-rect renderer
                  (sdl3.gui.menu.model:bar-left bar) (sdl3.gui.menu.model:bar-top bar)
                  (sdl3.gui.menu.model:bar-width bar) (sdl3.gui.menu.model:bar-height bar)
                  214 205 190)
  (stroke-menu-rect renderer
                    (sdl3.gui.menu.model:bar-left bar) (sdl3.gui.menu.model:bar-top bar)
                    (sdl3.gui.menu.model:bar-width bar) (sdl3.gui.menu.model:bar-height bar)
                    120 105 88)
  (loop for menu in (sdl3.gui.menu.model:bar-menus bar)
        for index from 0
        do (when (or (eql index (sdl3.gui.menu.model:bar-open-menu-index bar))
                     (eql index (sdl3.gui.menu.model:bar-hover-menu-index bar)))
             (fill-menu-rect renderer
                             (sdl3.gui.menu.model:menu-left menu)
                             (sdl3.gui.menu.model:menu-top menu)
                             (sdl3.gui.menu.model:menu-title-width menu)
                             (sdl3.gui.menu.model:bar-height bar)
                             166 201 186))
           (stroke-menu-rect renderer
                             (sdl3.gui.menu.model:menu-left menu)
                             (sdl3.gui.menu.model:menu-top menu)
                             (sdl3.gui.menu.model:menu-title-width menu)
                             (sdl3.gui.menu.model:bar-height bar)
                             120 105 88)
           (sdl3:set-render-draw-color renderer 35 35 35 255)
           (render-debug-text renderer
                              (+ (sdl3.gui.menu.model:menu-left menu)
                                 sdl3.gui.menu.model:+menu-title-pad-x+)
                              (+ (sdl3.gui.menu.model:bar-top bar) 10)
                              (sdl3.gui.menu.model:menu-title menu)))
  (let ((open-index (sdl3.gui.menu.model:bar-open-menu-index bar)))
    (when open-index
      (let* ((menu       (nth open-index (sdl3.gui.menu.model:bar-menus bar)))
             (panel-left (sdl3.gui.menu.model:menu-left menu))
             (panel-top  (+ (sdl3.gui.menu.model:bar-top bar)
                            (sdl3.gui.menu.model:bar-height bar))))
        (draw-dropdown-panel renderer menu panel-left panel-top
                             (sdl3.gui.menu.model:bar-hover-item-index bar))
        (let ((sub-entry-index (sdl3.gui.menu.model:bar-open-submenu-entry-index bar)))
          (when sub-entry-index
            (let ((entry (nth sub-entry-index (sdl3.gui.menu.model:menu-entries menu))))
              (when (typep entry 'sdl3.gui.menu.model:submenu-entry)
                (multiple-value-bind (sub-left sub-top)
                    (sdl3.gui.menu.model:submenu-panel-origin
                     menu panel-left panel-top sub-entry-index)
                  (draw-dropdown-panel renderer
                                       (sdl3.gui.menu.model:entry-submenu entry)
                                       sub-left sub-top
                                       (sdl3.gui.menu.model:bar-hover-sub-item-index bar)))))))))))
