(in-package :sdl3)

(defctype mouse-id :uint32)

;; SDL_MouseButtonFlags is a mask: bit (1 << (button - 1)) is set for each
;; button held.  The :button-* names are the masks of SDL_BUTTON_LEFT and
;; the others, not their numbers (1 to 5), which overlap as bits.
(defbitfield mouse-button-flags
  (:button-left 1)
  (:button-middle 2)
  (:button-right 4)
  (:button-x1 8)
  (:button-x2 16)
  (:button-lmask 1)
  (:button-mmask 2)
  (:button-rmask 4)
  (:button-x1mask 8)
  (:button-x2mask 16))

(defcenum system-cursor
  :default      
  :text         
  :wait         
  :crosshair    
  :progress     
  :nwse-resize  
  :nesw-resize  
  :ew-resize    
  :ns-resize    
  :move         
  :not-allowed  
  :pointer      
  :nw-resize    
  :n-resize     
  :ne-resize    
  :e-resize     
  :se-resize    
  :s-resize     
  :sw-resize    
  :w-resize     
  :count)
