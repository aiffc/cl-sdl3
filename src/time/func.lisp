(in-package :sdl3)

(defexport-fun "SDL_GetDateTimeLocalePreferences" :bool
  (data-format (:pointer data-format))
  (time-format (:pointer time-format)))

(defexport-fun "SDL_GetCurrentTime" :bool
  (ticks (:pointer stime)))

(defexport-fun "SDL_TimeToDateTime" :bool
  (ticks stime)
  (dt (:pointer (:struct data-time)))
  (local-time :bool))

(defexport-fun "SDL_DateTimeToTime" :bool
  (dt (:pointer (:struct data-time)))
  (ticks (:pointer stime)))

(defexport-fun "SDL_TimeToWindows" :void
  (ticks stime)
  (dw-low (:pointer :uint32))
  (dw-hight (:pointer :uint32)))

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




