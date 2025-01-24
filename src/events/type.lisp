(in-package :sdl3)

(cffi:defcstruct common-event 
  (type :uint32)
  (reserved :uint32)
  (reserved :uint64))

(cffi:defcenum event-type
  (:first 0)
  (:quit #x100)
  :terminating
  :low-memory     
  :will-enter-background
  :did-enter-background
  :will-enter-foreground 
  :did-enter-foreground
  :locale-changed
  :system-theme-changed
  (:display-orientation #x151)
  :display-added 
  :display-removed
  :display-moved
  :display-desktop-mode-changed
  :display-current-mode-changed
  :display-content-scale-changed
  ;; :display-first :display-orientation
  ;; :display-last :display-content-scale-changed
  (:window-shown #x202)
  :window-hidden
  :window-exposed
  :window-moved
  :window-resized
  :window-pixel-size-changed
  :window-metal-view-resized
  :window-minimized      
  :window-maximized      
  :window-restored       
  :window-mouse-enter    
  :window-mouse-leave    
  :window-focus-gained   
  :window-focus-lost     
  :window-close-requested
  :window-hit-test       
  :window-iccprof-changed
  :window-display-changed
  :window-display-scale-changed
  :window-safe-area-changed 
  :window-occluded          
  :window-enter-fullscreen  
  :window-leave-fullscreen  
  :window-destroyed         
  :window-hdr-state-changed
  ;; :window-first :window-shown
  ;; :window-last :window-hdr-state-changed
  (:key-down #x300) 
  :key-up                  
  :text-editing            
  :text-input              
  :keymap-changed          
  :keyboard-added         
  :keyboard-removed       
  :text-editing-candidates
  (:mouse-motion #x400)
  :mouse-button-down      
  :mouse-button-up        
  :mouse-wheel            
  :mouse-added            
  :mouse-removed          
  (:joystick-axis-motion #x600)
  :joystick-ball-motion         
  :joystick-hat-motion          
  :joystick-button-down         
  :joystick-button-up           
  :joystick-added               
  :joystick-removed             
  :joystick-battery-updated     
  :joystick-update-complete     
  (:gamepad-axis-motion #x650) 
  :gamepad-button-down          
  :gamepad-button-up            
  :gamepad-added                
  :gamepad-removed              
  :gamepad-remapped             
  :gamepad-touchpad-down        
  :gamepad-touchpad-motion      
  :gamepad-touchpad-up          
  :gamepad-sensor-update        
  :gamepad-update-complete      
  :gamepad-steam-handle-updated 
  (:finger-down #x700)
  :finger-up
  :finger-motion
  :finger-canceled
  (:clipboard-update #x900) 
  (:drop-file #x1000)
  :drop-text                
  :drop-begin               
  :drop-complete            
  :drop-position            
  (:audio-device-added #x1100)
  :audio-device-removed       
  :audio-device-format-changed
  (:sensor-update #x1200)
  (:pen-proximity-in #x1300)
  :pen-proximity-out         
  :pen-down                  
  :pen-up                    
  :pen-button-down           
  :pen-button-up             
  :pen-motion                
  :pen-axis                  
  (:camera-device-added #x1400)
  :camera-device-removed        
  :camera-device-approved       
  :camera-device-denied         
  (:render-targets-reset #x2000)
  :render-device-reset
  :render-device-lost
  (:private0 #x4000)
  :private1
  :private2
  :private3
  (:poll-sentinel #x7f00)
  (:user #x8000)
  (:last #xffff)
  (:enum-padding #x7fffffff))

(cffi:defcstruct display-event 
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (display display-id)
  (data-1 :int32)
  (data-2 :int32))

(cffi:defcstruct window-event 
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window window-id)
  (data-1 :int32)
  (data-2 :int32))

(cffi:defcstruct keyboard-device-event 
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which keyboard-id))

(cffi:defcstruct keyboard-event 
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window window-id)
  (which keyboard-id)
  (scancode scancode)
  (key keycode)
  (mod keymod)
  (raw :uint16)
  (down :bool)
  (repeat :bool))

(cffi:defcstruct text-editing-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window window-id)
  (text :string)
  (start :int32)
  (length :int32))

(cffi:defcstruct text-editing-candidates-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window window-id)
  (candidates :string)
  (num-candidates :int32)
  (selected-candidate :int32)
  (horizontal :bool)
  (padding1 :uint8)
  (padding2 :uint8)
  (padding3 :uint8))

(cffi:defcstruct text-input-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window window-id)
  (text :string))

(cffi:defcstruct mouse-device-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which mouse-id))

(cffi:defcstruct mouse-motion-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window window-id)
  (which mouse-id)
  (state mouse-button-flags)
  (x :float)
  (y :float)
  (xrel :float)
  (yrel :float))

(cffi:defcstruct mouse-button-event 
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window window-id)
  (which mouse-id)
  (button :uint8)
  (down :bool)
  (clicks :uint8)
  (padding :uint8)
  (x :float)
  (y :float))

(cffi:defcenum mouse-wheel-direction
  :normal
  :flipped)

(cffi:defcstruct mouse-wheel-event 
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window window-id)
  (which mouse-id)
  (x :float)
  (y :float)
  (direction mouse-wheel-direction)
  (mouse-x :float)
  (mouse-y :float))

(cffi:defctype joystick-id :uint32)
(cffi:defcstruct joy-device-event 
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which joystick-id))

(cffi:defcstruct joy-axis-event 
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which joystick-id)
  (axis :uint8)
  (padding1 :uint8)
  (padding2 :uint8)
  (padding3 :uint8)
  (value :int16)
  (padding4 :uint16))

(cffi:defcstruct joy-ball-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which joystick-id)
  (ball :uint8)
  (padding1 :uint8)
  (padding2 :uint8)
  (padding3 :uint8)
  (xrel :int16)
  (yrel :int16))

(cffi:defcstruct joy-hat-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which joystick-id)
  (hat :uint8)
  (value :uint8)
  (padding1 :uint8)
  (padding2 :uint8))

(cffi:defcstruct joy-button-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which joystick-id)
  (button :uint8)
  (down :bool)
  (padding1 :uint8)
  (padding2 :uint8))

(cffi:defcstruct joy-battery-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which joystick-id)
  (state power-state)
  (percent :int))

(cffi:defcstruct gamepad-device-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which joystick-id))

(cffi:defcstruct gamepad-axis-event 
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which joystick-id)
  (axis :uint8)
  (padding1 :uint8)
  (padding2 :uint8)
  (padding3 :uint8)
  (value :int16)
  (padding4 :uint16))

(cffi:defcstruct gamepad-button-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which joystick-id)
  (button :uint8)
  (down :bool)
  (padding1 :uint8)
  (padding2 :uint8))

(cffi:defcstruct gamepad-touchpad-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which joystick-id)
  (touchad :int32)
  (finger :int32)
  (x :float)
  (y :float)
  (pressure :float))

(cffi:defcstruct gamepad-sensor-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which joystick-id)
  (sensor :int32)
  (data :float :count 3)
  (sensor-timestamp :uint64))

(cffi:defcstruct audio-device-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which audio-device-id)
  (recording :bool)
  (panding1 :uint8)
  (panding2 :uint8)
  (panding3 :uint8))

(cffi:defcstruct camera-device-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which camera-id))

(cffi:defcstruct sensor-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which sensor-id)
  (data :float :count 6)
  (sensor-timestamp :uint64))

(cffi:defcstruct quit-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64))

(cffi:defcstruct user-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window-id window-id)
  (code :int32)
  (data1 :pointer)
  (data2 :pointer))

(cffi:defctype touch-id :uint64)
(cffi:defctype finger-id :uint64)
(cffi:defcstruct touch-finger-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (touch-id touch-id)
  (finger-id finger-id)
  (x :float)
  (y :float)
  (dx :float)
  (dy :float)
  (pressure :float)
  (window-id window-id))

(cffi:defctype pen-id :uint32)
(cffi:defcstruct pen-proximity-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window-id window-id)
  (which pen-id))

(cffi:defbitfield pen-input-flags
  (:down #x1)
  (:button-1 #x2)
  (:button-2 #x4)
  (:button-3 #x8)
  (:button-4 #x10)
  (:button-5 #x20)
  (:eraser-tip  #x40000000))

(cffi:defcstruct pen-touch-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window-id window-id)
  (which pen-id)
  (pen-state pen-input-flags)
  (x :float)
  (y :float)
  (eraser :bool)
  (down :bool))

(cffi:defcstruct pen-motion-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window-id window-id)
  (which pen-id)
  (pen-state pen-input-flags)
  (x :float)
  (y :float))

(cffi:defcstruct pen-button-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window-id window-id)
  (which pen-id)
  (pen-state pen-input-flags)
  (x :float)
  (y :float)
  (button :uint8)
  (down :bool))

(cffi:defcenum pen-axis
  :pressure
  :xtilt
  :ytilt
  :distance
  :rotation
  :slider
  :tangential_pressure
  :count)

(cffi:defcstruct pen-axis-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window-id window-id)
  (which pen-id)
  (pen-state pen-input-flags)
  (x :float)
  (y :float)
  (axis pen-axis)
  (value :float))

(cffi:defcstruct render-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window-id window-id))

(cffi:defcstruct drop-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window-id window-id)
  (x :float)
  (y :float)
  (source :string)
  (data :string))

(cffi:defcstruct clipboard-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (owner :bool)
  (num-mime-types :int32)
  (mime-types (:pointer :string)))

(cffi:defcunion event
  (type :uint32)
  (common (:struct common-event))
  (display (:struct display-event))
  (window (:struct window-event))
  (kdevice (:struct keyboard-device-event))
  (key (:struct keyboard-event))
  (edit (:struct text-editing-event))
  (edit-candidates (:struct text-editing-candidates-event))
  (text (:struct text-input-event))
  (mdevice (:struct mouse-device-event))
  (motion (:struct mouse-motion-event))
  (button (:struct mouse-button-event))
  (wheel (:struct mouse-wheel-event))
  (jdevice (:struct joy-device-event))
  (jaxis (:struct joy-axis-event))
  (jball (:struct joy-ball-event))
  (jhat (:struct joy-hat-event))
  (jbutton (:struct joy-button-event))
  (jbattery (:struct joy-battery-event))
  (gdevice (:struct gamepad-device-event))
  (gaxis (:struct gamepad-axis-event))
  (gbutton (:struct gamepad-button-event))
  (gtouchpad (:struct gamepad-touchpad-event))
  (gsensor (:struct gamepad-sensor-event))
  (adevice (:struct audio-device-event))
  (cdevice (:struct camera-device-event))
  (sensor (:struct sensor-event))
  (quit (:struct quit-event))
  (user (:struct user-event))
  (tfinger (:struct touch-finger-event))
  (pproximity (:struct pen-proximity-event))
  (ptouch (:struct pen-touch-event))
  (pmotion (:struct pen-motion-event))
  (pbutton (:struct pen-button-event))
  (paxis (:struct pen-axis-event))
  (render (:struct render-event))
  (drop (:struct drop-event))
  (clipboard (:struct clipboard-event))
  (padding :uint8 :count 128))

(cffi:defcenum event-action 
  :addevent
  :peekevent
  :getevent)
