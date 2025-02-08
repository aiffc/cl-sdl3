(in-package :sdl3)

(cffi:defctype window-id :uint32)

(defcenum system-theme
  :unknown
  :light
  :dark)

(cffi:defctype display-id :uint32)

(defcenum display-operation
  :unknown
  :landscape
  :landscape_flipped
  :portrait
  :portrait_flipped)

(deflsp-type display-mode
  (display-id display-id)
  (format pixel-format)
  (w :int)
  (h :int)
  (pixel-density :float)
  (refresh-rate :float)
  (refresh-rate-numerator :int)
  (refresh-rate-denominator :int)
  (internal :pointer))

(defbitfield (window-flags :uint64)
  (:fullscreen           #x0000000000000001)    
  (:opengl               #x0000000000000002)    
  (:occluded             #x0000000000000004)    
  (:hidden               #x0000000000000008)    
  (:borderless           #x0000000000000010)    
  (:resizable            #x0000000000000020)    
  (:minimized            #x0000000000000040)    
  (:maximized            #x0000000000000080)    
  (:mouse-grabbed        #x0000000000000100)    
  (:input-focus          #x0000000000000200)    
  (:mouse-focus          #x0000000000000400)    
  (:external             #x0000000000000800)    
  (:modal                #x0000000000001000)    
  (:high-pixel-density   #x0000000000002000)    
  (:mouse-capture        #x0000000000004000)    
  (:mouse-relative-mode  #x0000000000008000)    
  (:always-on-top        #x0000000000010000)    
  (:utility              #x0000000000020000)    
  (:tooltip              #x0000000000040000)    
  (:popup-menu           #x0000000000080000)    
  (:keyboard-grabbed     #x0000000000100000)    
  (:vulkan               #x0000000010000000)    
  (:metal                #x0000000020000000)    
  (:transparent          #x0000000040000000)    
  (:not-focusable        #x0000000080000000))

(defcenum flash-operation
  :cancel
  :briefly
  :until-focused)

(defcenum glattr
  :red-size
  :green-size                  
  :blue-size                   
  :alpha-size                  
  :buffer-size                 
  :doublebuffer                
  :depth-size                  
  :stencil-size                
  :accum-red-size              
  :accum-green-size            
  :accum-blue-size             
  :accum-alpha-size            
  :stereo                      
  :multisamplebuffers          
  :multisamplesamples          
  :accelerated-visual          
  :retained-backing            
  :context-major-version       
  :context-minor-version       
  :context-flags               
  :context-profile-mask        
  :share-with-current-context  
  :framebuffer-srgb-capable    
  :context-release-behavior    
  :context-reset-notification  
  :context-no-error
  :floatbuffers
  :egl-platform)
