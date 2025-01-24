(in-package :sdl3)

(cffi:defctype properties-id :uint32)

(cffi:defcstruct storage-interface
  (version :uint32)
  (close :pointer)
  (ready :pointer)
  (enumerate :pointer)
  (info :pointer)
  (read_file :pointer)
  (write_file :pointer)
  (mkdir :pointer)
  (remove :pointer)
  (rename :pointer)
  (copy :pointer)
  (space-remaining :pointer))
