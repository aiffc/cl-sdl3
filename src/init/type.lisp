(in-package :sdl3)

(defbitfield init-flags
  (:audio      #x00000010)
  (:video      #x00000020)
  (:joystick   #x00000200)
  (:haptic     #x00001000)
  (:gamepad    #x00002000)
  (:events     #x00004000)
  (:sensor     #x00008000)
  (:camera     #x00010000))

(alexandria:define-constant +app-name-string+         "SDL.app.metadata.name" :test #'string=)
(alexandria:define-constant +app-version-string+      "SDL.app.metadata.version" :test #'string=)
(alexandria:define-constant +app-identifier-string+   "SDL.app.metadata.identifier" :test #'string=)
(alexandria:define-constant +app-creator-string+      "SDL.app.metadata.creator" :test #'string=)
(alexandria:define-constant +app-copyright-string+    "SDL.app.metadata.copyright" :test #'string=)
(alexandria:define-constant +app-url-string+          "SDL.app.metadata.url" :test #'string=)
(alexandria:define-constant +app-type-string+         "SDL.app.metadata.type" :test #'string=)    


(export '+app-name-string+)
(export '+app-version-string+)
(export '+app-identifier-string+)
(export '+app-creator-string+)
(export '+app-copyright-string+)
(export '+app-url-string+)
(export '+app-type-string+)
