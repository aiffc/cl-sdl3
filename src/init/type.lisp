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

(defconstant +name-string+         "sdl.app.metadata.name")
(defconstant +version-string+      "sdl.app.metadata.version")
(defconstant +identifier-string+   "sdl.app.metadata.identifier")
(defconstant +creator-string+      "sdl.app.metadata.creator")
(defconstant +copyright-string+    "sdl.app.metadata.copyright")
(defconstant +url-string+          "sdl.app.metadata.url")
(defconstant +type-string+         "sdl.app.metadata.type")    


(export '+name-string+)
(export '+version-string+)
(export '+identifier-string+)
(export '+creator-string+)
(export '+copyright-string+)
(export '+url-string+)
(export '+type-string+)
