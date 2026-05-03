(defpackage :sdl3.gui.menu.model
  (:nicknames :gui.menu.model
              :sdl3.gui.menu
              :gui.menu)
  (:use #:cl)
  (:export
   ;; classes
   #:menu-entry
   #:command-entry
   #:separator-entry
   #:submenu-entry
   #:dropdown-menu
   #:menu-bar
   ;; entry accessors
   #:entry-label
   #:entry-hotkey
   #:entry-action
   #:entry-submenu
   ;; dropdown-menu accessors
   #:menu-title
   #:menu-entries
   #:menu-left
   #:menu-top
   #:menu-title-width
   #:menu-panel-width
   #:menu-panel-height
   ;; menu-bar accessors
   #:bar-menus
   #:bar-left
   #:bar-top
   #:bar-width
   #:bar-height
   #:bar-open-menu-index
   #:bar-hover-menu-index
   #:bar-hover-item-index
   #:bar-open-submenu-entry-index
   #:bar-hover-sub-item-index
   ;; constants
   #:+font-char-width+
   #:+font-text-height+
   #:+menu-bar-height+
   #:+menu-title-pad-x+
   #:+menu-title-gap+
   #:+menu-item-pad-x+
   #:+menu-item-pad-y+
   #:+menu-item-gap-label-hotkey+
   #:+submenu-arrow-width+
   #:+separator-height+
   #:+submenu-min-width+
   ;; functions
   #:text-width
   #:entry-row-height
   #:entry-content-width
   #:layout-menu-bar
   #:title-menu-index-at
   #:dropdown-item-index-at
   #:submenu-panel-origin
   #:open-menu
   #:close-menu))

(defpackage :sdl3.gui.menu.controller
  (:nicknames :gui.menu.controller)
  (:use #:cl)
  (:export
   #:handle-left-click
   #:handle-mouse-motion))

(defpackage :sdl3.gui.menu.sdl3-renderer
  (:nicknames :gui.menu.sdl3-renderer)
  (:use #:cl)
  (:export
   #:render-debug-text
   #:draw-menu-bar))
