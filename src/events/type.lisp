(in-package :sdl3)

(deflsp-type common-event 
  (type :uint32)
  (reserved :uint32)
  (timestamp :uint64))

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

(deflsp-type display-event 
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (display display-id)
  (data-1 :int32)
  (data-2 :int32))

(deflsp-type window-event 
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window window-id)
  (data-1 :int32)
  (data-2 :int32))

(deflsp-type keyboard-device-event 
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which keyboard-id))

(deflsp-type keyboard-event 
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

(deflsp-type text-editing-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window window-id)
  (text :string)
  (start :int32)
  (length :int32))

(deflsp-type text-editing-candidates-event
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

(deflsp-type text-input-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window window-id)
  (text :string))

(deflsp-type mouse-device-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which mouse-id))

(deflsp-type mouse-motion-event
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

(deflsp-type mouse-button-event 
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

(deflsp-type mouse-wheel-event 
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
(deflsp-type joy-device-event 
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which joystick-id))

(deflsp-type joy-axis-event 
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

(deflsp-type joy-ball-event
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

(deflsp-type joy-hat-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which joystick-id)
  (hat :uint8)
  (value :uint8)
  (padding1 :uint8)
  (padding2 :uint8))

(deflsp-type joy-button-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which joystick-id)
  (button :uint8)
  (down :bool)
  (padding1 :uint8)
  (padding2 :uint8))

(deflsp-type joy-battery-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which joystick-id)
  (state power-state)
  (percent :int))

(deflsp-type gamepad-device-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which joystick-id))

(deflsp-type gamepad-axis-event 
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

(deflsp-type gamepad-button-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which joystick-id)
  (button :uint8)
  (down :bool)
  (padding1 :uint8)
  (padding2 :uint8))

(deflsp-type gamepad-touchpad-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which joystick-id)
  (touchad :int32)
  (finger :int32)
  (x :float)
  (y :float)
  (pressure :float))

(deflsp-type gamepad-sensor-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which joystick-id)
  (sensor :int32)
  (data :float :count 3)
  (sensor-timestamp :uint64))

(deflsp-type audio-device-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which audio-device-id)
  (recording :bool)
  (panding1 :uint8)
  (panding2 :uint8)
  (panding3 :uint8))

(deflsp-type camera-device-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which camera-id))

(deflsp-type sensor-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (which sensor-id)
  (data :float :count 6)
  (sensor-timestamp :uint64))

(deflsp-type quit-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64))

(deflsp-type user-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window-id window-id)
  (code :int32)
  (data1 :pointer)
  (data2 :pointer))

(cffi:defctype touch-id :uint64)
(cffi:defctype finger-id :uint64)
(deflsp-type touch-finger-event
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
(deflsp-type pen-proximity-event
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

(deflsp-type pen-touch-event
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

(deflsp-type pen-motion-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window-id window-id)
  (which pen-id)
  (pen-state pen-input-flags)
  (x :float)
  (y :float))

(deflsp-type pen-button-event
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

(deflsp-type pen-axis-event
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

(deflsp-type render-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window-id window-id))

(deflsp-type drop-event
  (type event-type)
  (reserved :uint32)
  (timestamp :uint64)
  (window-id window-id)
  (x :float)
  (y :float)
  (source :string)
  (data :string))

(deflsp-type clipboard-event
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
(export 'event)

(cffi:defcenum event-action 
  :addevent
  :peekevent
  :getevent)
