(in-package :sdl3)

(cffi:defctype stime :int64)

(cffi:defcenum data-format 
  (:yyyymmdd 0)
  (:ddmmyyyy 1)
  (:mmddyyyy 2))

(cffi:defcenum time-format 
  (:24hr 0)
  (:12hr 1))

(cffi:defcstruct data-time
  (year :int)
  (month :int)
  (day :int)
  (hour :int)
  (minute :int)
  (second :int)
  (nanosecond :int)
  (day-of-week :int)
  (utc-offset :int))
