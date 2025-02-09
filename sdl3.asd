(defsystem "sdl3"
  :version "0.0.1"
  :author "YJC"
  :license ""
  :depends-on (:alexandria
               :defclass-std
               :cffi-libffi
               #+darwin
               :trivial-main-thread
               #+darwin
               :float-features)
  :components ((:module "src"
		:components
		((:file "package")
		 (:file "lib")
		 (:file "util")
		 (:file "translate-type")
		 (:file "translate-fun")
		 (:module "init"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "hints"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "error"
		  :components
		  ((:file "func")))
		 (:module "properties"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "log"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "rect"
		  :components
		  ((:file "type")
		   (:file "func")
		   (:file "wrap")))
		 (:module "keyboard"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "touch"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "sensor"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "power"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "guid"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "gamepad"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "joystick"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "haptic"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "audio"
		  :components
		  ((:file "type")
		   (:file "func")
		   (:file "wrap")))
		 (:module "time"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "timer"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "sharedobject"
		  :components
		  ((:file "func")))
		 (:module "thread"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "atomic"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "mutex"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "filesystem"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "iostream"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "asyncio"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "storage"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "pixels"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "blendmode"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "surface"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "mouse"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "camera"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "clipboard"
		  :components
		  ((:file "func")))
		 (:module "dialog"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "gpu"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "messagebox"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "vulkan"
		  :components
		  ((:file "func")))
		 (:module "metal"
		  :components
		  ((:file "func")))
		 (:module "process"
		  :components
		  ((:file "func")))
		 (:module "bits"
		  :components
		  ((:file "func")))
		 (:module "endian"
		  :components
		  ((:file "func")))
		 (:module "assert"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "cpuinfo"
		  :components
		  ((:file "func")))
		 (:module "intrinsics")
		 (:module "locale"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "system")
		 (:module "misc"
		  :components
		  ((:file "func")))
		 (:module "video"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "render"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "events"
		  :components
		  ((:file "type")
		   (:file "func")))
		 (:module "main"
		  :components
		  ((:file "type")
		   (:file "func")
		   (:file "wrap")))
		 ;;(:module "stdinc")
		 (:module "extr"
		  :components
		  ((:module "sdl-image"
		    :components
			    ((:file "package")
			     (:file "lib")
			     (:file "type")
			     (:file "func")))
		   (:module "sdl-ttf"
		    :components
			    ((:file "package")
			     (:file "lib")
			     (:file "type")
			     (:file "func")))))
		 (:file "load-docstring"))))
  :description "common lisp bind sdl3 use cffi")


(defsystem "sdl3/tests"
  :version "0.0.1"
  :author "YJC"
  :license ""
  :depends-on (:sdl3)
  :components ((:module "test"
		:components
		((:file "util")
		 (:module "rendertest"
		  :components
		  ((:file "package")
		   (:file "01clear")
		   (:file "02primitives")
		   (:file "03lines")
		   (:file "04points")
		   (:file "05rectangles")
		   (:file "06texture")
		   (:file "07stream-texture")
		   (:file "08rotating-textures")
		   (:file "09scaling-textures")
		   (:file "10geometry")
		   (:file "11color-mode")
		   (:file "14viewport")
		   (:file "15cliprect")
		   (:file "17read-pixel")
		   (:file "18debug-text")))
		 (:module "event"
		  :components
		  ((:file "package")
		   (:file "keyboard")
		   (:file "mouse")))
		 (:module "audio"
		  :components
		  ((:file "package")
		   (:file "01simple-playback")
		   (:file "02simple-playback-callback")
		   (:file "03load-wav")))
                 (:module "demo"
		  :components
		  ((:file "package")
		   (:file "snake")))
		 (:module "gpu"
		  :components
		  ((:file "package")
		   (:file "triangle"))))))
  :description "test function here")
