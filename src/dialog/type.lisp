(in-package :sdl3)

(cffi:defcstruct dialog-file-filter
  (name :string)
  (pattern :string))

(cffi:defcenum file-dialog-type
  :openfile
  :savefile
  :openfolder)
