(in-package :sdl3.render.test)

(sdl3:def-app-init 18-init (argc argv)
  (declare (ignore argc argv))
  (sdl3:set-app-metadata "Example Renderer Debug Texture" "1.0" "com.example.renderer-debug-text")
  (when (not (sdl3:init :video))
    (format t "~a~%" (sdl3:get-error))
    (return-from 18-init :failure))
  (multiple-value-bind (rst window renderer)
      (sdl3:create-window-and-renderer "examples/renderer/debug-text" +window-width+ +window-height+ :resizable)
    (if (not rst)
	(progn 
	  (format t "~a~%" (sdl3:get-error))
	  (return-from 18-init :failure))
	(setf *window-handle* window
	      *renderer-handler* renderer)))
  :continue)

(sdl3:def-app-iterate 18-iterate ()
  (let ((char-size 8))
    (sdl3:set-render-draw-color *renderer-handler* 0 0 0 255)
    (sdl3:render-clear *renderer-handler*)

    (sdl3:set-render-draw-color *renderer-handler* 255 255 255 255)
    (sdl3:render-debug-text *renderer-handler* 270.0 100.0 "Hello World!")
    (sdl3:render-debug-text *renderer-handler* 224.0 150.0 "This is some debug text.")

    (sdl3:set-render-draw-color *renderer-handler* 51 102 255 255)
    (sdl3:render-debug-text *renderer-handler* 184.0 200.0 "You can do it in different colors.")
    (sdl3:set-render-draw-color *renderer-handler* 255 255 255 255)
    
    (sdl3:set-render-scale *renderer-handler* 4.0 4.0)
    (sdl3:render-debug-text *renderer-handler* 14.0 65.0 "It can be scaled.")
    (sdl3:set-render-scale *renderer-handler* 1.0 1.0)
    (sdl3:render-debug-text *renderer-handler* 64.0 350.0 "This only does ASCII chars. So this laughing emoji won't draw: 🤣")
    (sdl3:render-debug-text *renderer-handler*
			    (%u:to-single-float (/ (- +window-width+ (* char-size 46)) 2.0))
			    400.0
			    (format nil "(This program has been running for ~a seconds.)"
				    (floor (/ (sdl3:get-ticks) 1000.0))))
    ;; not support SDL_RenderDebugTextFormat 
    (sdl3:render-present *renderer-handler*))
  :continue)

(sdl3:def-app-event 18-event (event-type)
  (when (eql event-type :quit)
    (return-from 18-event :success))
  :continue)

(sdl3:def-app-quit 18-quit (result)
  (declare (ignore result)))

(defun do-debug-text-demo ()
  (renderer-init)
  (sdl3:enter-app-main-callbacks '18-init '18-iterate '18-event '18-quit))
