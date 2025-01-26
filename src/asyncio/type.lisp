(in-package :sdl3)

(cffi:defcenum async-io-task-type
  :read
  :write
  :close)


(cffi:defcenum async-io-result
  :asyncio_complete
  :asyncio_failure
  :asyncio_canceled)

(deflsp-type async-io-outcome
  (asyncio :pointer)
  (type async-io-task-type)
  (result async-io-result)
  (buffer :pointer)
  (offset :uint64)
  (bytes-requested :uint64)
  (bytes-transferred :uint64)
  (userdata :pointer))
