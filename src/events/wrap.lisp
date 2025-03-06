(in-package :sdl3)

(defmacro map-event-cases (&body clause-class-pairs)
  `(case type-id
     ,@(loop for (clause class) in clause-class-pairs
             collect `(,(loop for key in clause
                                  collect (cffi:foreign-enum-value 'event-type key))
                       (cffi:mem-ref *event '(:struct ,class))))))

(defun event-unmarshal (*event)
  "Takes a pointer to the SDL_Event union and returns the corresponding lisp event struct"
  (let ((type-id (cffi:mem-ref *event :uint32)))
    (or
     (map-event-cases
       ((:quit) quit-event)
       ((:display-orientation :display-added :display-removed :display-moved
         :display-desktop-mode-changed :display-current-mode-changed :display-content-scale-changed)
        display-event)
       ((:window-shown :window-hidden :window-exposed :window-moved :window-resized
         :window-pixel-size-changed :window-metal-view-resized
         :window-minimized :window-maximized :window-restored
                       :window-mouse-enter :window-mouse-leave :window-focus-gained :window-focus-lost
                       :window-close-requested
         :window-hit-test
                       :window-iccprof-changed
         :window-display-changed :window-display-scale-changed :window-safe-area-changed
                       :window-occluded :window-enter-fullscreen :window-leave-fullscreen
         :window-destroyed
                       :window-hdr-state-changed)
        window-event)
       ((:key-down :key-up) keyboard-event)
       ((:text-editing) text-editing-event)
       ((:text-editing-candidates) text-editing-candidates-event)
       ((:text-input) text-input-event)
       ((:mouse-added :mouse-removed) mouse-device-event)
       ((:mouse-motion) mouse-motion-event)
       ((:mouse-button-up :mouse-button-down) mouse-button-event)
       ((:mouse-wheel) mouse-wheel-event)
       ((:joystick-axis-motion) joy-axis-event)
       ((:joystick-ball-motion) joy-ball-event)
       ((:joystick-hat-motion) joy-hat-event)
       ((:joystick-button-up :joystick-button-down) joy-button-event)
       ((:joystick-added :joystick-removed :joystick-update-complete) joy-device-event)
       ((:joystick-battery-updated) joy-battery-event)
       ((:gamepad-axis-motion) gamepad-axis-event)
       ((:gamepad-button-down :gamepad-button-up) gamepad-button-event)
       ((:gamepad-added :gamepad-removed :gamepad-update-complete :gamepad-steam-handle-updated) gamepad-device-event)
       ((:gamepad-touchpad-up :gamepad-touchpad-down :gamepad-touchpad-motion) gamepad-touchpad-event)
       ((:gamepad-sensor-update) gamepad-sensor-event)
       ((:audio-device-added :audio-device-format-changed :audio-device-removed) audio-device-event)
       ((:camera-device-added :camera-device-removed :camera-device-approved :camera-device-denied) camera-device-event)
       ((:render-targets-reset :render-device-reset :render-device-lost) render-event)
       ((:finger-down :finger-up :finger-canceled :finger-motion) touch-finger-event)
       ((:pen-proximity-in :pen-proximity-out) pen-proximity-event)
       ((:pen-motion) pen-motion-event)
       ((:pen-down :pen-up) pen-touch-event)
       ((:pen-button-down :pen-button-up) pen-button-event)
       ((:pen-axis) pen-axis-event)
       ((:drop-begin :drop-file :drop-complete :drop-position) drop-event)
       ((:clipboard-update) clipboard-event)
       ((:sensor-update) sensor-event))
     (when (<= #x8000 type-id #xFFFF)
       (cffi:mem-ref *event '(:struct user-event))))))
(export 'event-unmarshal)

(defun poll-event* ()
  "Polls for event returns either
1. nil ;; if there are no events in the queue
2. (value event-object event-type) ;; see union `event' and `event-type'

See `pool-event' for more details."

  (cffi:with-foreign-object (*event '(:union sdl3:event))
    (let ((success (sdl3:poll-event *event)))
      (when success
        (let* ((type (cffi:mem-ref *event 'event-type)))
          (values (event-unmarshal *event) type))))))
(export 'poll-event*)

(defun wait-event* ()
  "Waits for event and returns either
1. nil ;; if any error happens
2. (value event-object event-type) ;; see union `event' and `event-type'

See `wait-event' for more details."
  (cffi:with-foreign-object (*event '(:union sdl3:event))
    (let ((success (sdl3:wait-event *event)))
      (when success
        (let* ((type (cffi:mem-ref *event 'event-type)))
          (values (event-unmarshal *event) type))))))
(export 'wait-event*)

(defun wait-event-timeout* (timeout-ms)
  "Waits for event and returns either
1. nil ;; if any error happens or timeout occurs
2. (value event-object event-type) ;; see union `event' and `event-type'

See `wait-event-timeout' for more details."
  (cffi:with-foreign-object (*event '(:union sdl3:event))
    (let ((success (sdl3:wait-event-timeout *event timeout-ms)))
      (when success
        (let* ((type (cffi:mem-ref *event 'event-type)))
          (values (event-unmarshal *event) type))))))
(export 'wait-event-timeout*)
