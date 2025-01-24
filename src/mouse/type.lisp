(in-package :sdl3)

(cffi:defctype mouse-id :uint32)

(cffi:defbitfield mouse-button-flags
  (:button-left 1)
  (:button-middle 2)
  (:button-right 3)
  (:button-x1 4)
  (:button-x2 5)
  (:button-lmask 1)
  (:button-mmask 2)
  (:button-rmask 4)
  (:button-x1mask 8)
  (:button-x2mask 16))

(cffi:defcenum system-cursor
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
