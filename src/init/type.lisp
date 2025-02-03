(in-package :sdl3)

(cffi:defbitfield init-flags
  (:audio      #x00000010)
  (:video      #x00000020)
  (:joystick   #x00000200)
  (:haptic     #x00001000)
  (:gamepad    #x00002000)
  (:events     #x00004000)
  (:sensor     #x00008000)
  (:camera     #x00010000))

(defconstant +app-name-string+         "SDL.app.metadata.name")
(defconstant +app-version-string+      "SDL.app.metadata.version")
(defconstant +app-identifier-string+   "SDL.app.metadata.identifier")
(defconstant +app-creator-string+      "SDL.app.metadata.creator")
(defconstant +app-copyright-string+    "SDL.app.metadata.copyright")
(defconstant +app-url-string+          "SDL.app.metadata.url")
(defconstant +app-type-string+         "SDL.app.metadata.type")    


(export '+app-name-string+)
(export '+app-version-string+)
(export '+app-identifier-string+)
(export '+app-creator-string+)
(export '+app-copyright-string+)
(export '+app-url-string+)
(export '+app-type-string+)
