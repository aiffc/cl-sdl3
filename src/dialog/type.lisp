(in-package :sdl3)

(deflsp-type dialog-file-filter
  (name :string)
  (pattern :string))

(defcenum file-dialog-type
  :openfile
  :savefile
  :openfolder)
