(in-package :sdl3)

(deflsp-type io-stream-interface
  (version :uint32)
  (size :pointer)
  (seek :pointer)
  (read :pointer)
  (write :pointer)
  (flush :pointer)
  (close :pointer))

(defcenum io-status
  :ready
  :error
  :eof
  :not_ready
  :readonly
  :writeonly)

(defcenum io-whence
  :set
  :cur
  :end)
