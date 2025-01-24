(in-package :sdl3)

(cffi:defcenum log-priority
 :invalid
 :trace
 :verbose
 :debug
 :info
 :warn
 :error
 :critical
 :count)
