(in-package :sdl3)

(defctype properties-id :uint32)

(deflsp-type storage-interface
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
