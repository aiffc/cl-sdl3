(in-package :sdl3)

(cffi:defctype stime :int64)

(defcenum data-format 
  (:yyyymmdd 0)
  (:ddmmyyyy 1)
  (:mmddyyyy 2))

(defcenum time-format 
  (:24hr 0)
  (:12hr 1))

(deflsp-type data-time
  (year :int)
  (month :int)
  (day :int)
  (hour :int)
  (minute :int)
  (second :int)
  (nanosecond :int)
  (day-of-week :int)
  (utc-offset :int))
