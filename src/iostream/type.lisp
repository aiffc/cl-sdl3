(in-package :sdl3)

(cffi:defcstruct io-stream-interface
  (version :uint32)
  (size :pointer)
  (seek :pointer)
  (read :pointer)
  (write :pointer)
  (flush :pointer)
  (close :pointer))

(cffi:defcenum io-status
  :ready
  :error
  :eof
  :not_ready
  :readonly
  :writeonly)

(cffi:defcenum io-whence
  :set
  :cur
  :end)
