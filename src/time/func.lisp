(in-package :sdl3)

(defwrap-fun "SDL_GetDateTimeLocalePreferences" :bool
    (t t)
  (data-format (:pointer data-format) :direction :output)
  (time-format (:pointer time-format) :direction :output))

(defwrap-fun "SDL_GetCurrentTime" :bool
    (t t)
  (ticks (:pointer stime) :direction :output))

(defwrap-fun "SDL_TimeToDateTime" :bool
    (t t)
  (ticks stime)
  (dt (:pointer (:struct data-time)) :direction :output)
  (local-time :bool))

(defwrap-fun "SDL_DateTimeToTime" :bool
    (t t)
  (dt (:pointer (:struct data-time)) :direction :input)
  (ticks (:pointer stime) :direction :output))

(defwrap-fun "SDL_TimeToWindows" :void
  (ticks stime)
  (dw-low (:pointer :uint32) :direction :output)
  (dw-hight (:pointer :uint32) :direction :output))

(defexport-fun "SDL_TimeFromWindows" stime
  (dw-low :uint32)
  (dw-hight :uint32))

(defexport-fun "SDL_GetDaysInMonth" :int
  (year :int)
  (month :int))

(defexport-fun "SDL_GetDayOfYear" :int
  (year :int)
  (month :int)
  (day :int))

(defexport-fun "SDL_GetDayOfWeek" :int
  (year :int)
  (month :int)
  (day :int))




