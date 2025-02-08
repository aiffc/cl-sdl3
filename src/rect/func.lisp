(in-package :sdl3)

(defwrap-fun "SDL_HasRectIntersection" :bool
    (t t)
  (a (:pointer (:struct rect)) :direction :input)
  (b (:pointer (:struct rect)) :direction :input))

(defwrap-fun "SDL_GetRectIntersection" :bool
    (t t)
  (a (:pointer (:struct rect)) :direction :input)
  (b (:pointer (:struct rect)) :direction :input)
  (ret (:pointer (:struct rect)) :direction :output))

(defwrap-fun "SDL_GetRectUnion" :bool
    (t t)
  (a (:pointer (:struct rect)) :direction :input)
  (b (:pointer (:struct rect)) :direction :input)
  (ret (:pointer (:struct rect))  :direction :output))

(defwrap-fun "SDL_GetRectEnclosingPoints" :bool
    (t t)
  (point (:pointer (:struct point)) :direction :input :bind-count count)
  (count :int :bind-val point)
  (clip (:pointer (:struct rect)) :direction :input)
  (ret (:pointer (:struct rect)) :direction :output))

(defwrap-fun "SDL_GetRectAndLineIntersection" :bool
    (t t)
  (rect (:pointer (:struct rect)) :direction :input)
  (x1 (:pointer :int) :direction :output)
  (y1 (:pointer :int) :direction :output)
  (x2 (:pointer :int) :direction :output)
  (y2 (:pointer :int) :direction :output))

(defwrap-fun "SDL_HasRectIntersectionFloat" :bool
    (t t)
  (a (:pointer (:struct frect)) :direction :input)
  (b (:pointer (:struct frect)) :direction :input))

(defwrap-fun "SDL_GetRectIntersectionFloat" :bool
    (t t)
  (a (:pointer (:struct frect)) :direction :input)
  (b (:pointer (:struct frect)) :direction :input)
  (ret (:pointer (:struct frect)) :direction :output))

(defwrap-fun "SDL_GetRectUnionFloat" :bool
    (t t)
  (a (:pointer (:struct frect)) :direction :input)
  (b (:pointer (:struct frect)) :direction :input)
  (ret (:pointer (:struct frect)) :direction :output))

(defwrap-fun "SDL_GetRectEnclosingPointsFloat" :bool
    (t t)
  (point (:pointer (:struct fpoint)) :direction :input :bind-count count)
  (count :int :bind-val point)
  (clip (:pointer (:struct frect)) :direction :input)
  (ret (:pointer (:struct frect)) :direction :output))

(defwrap-fun "SDL_GetRectAndLineIntersectionFloat" :bool
    (t t)
  (rect (:pointer (:struct frect)) :direction :input)
  (x1 (:pointer :float) :direction :output)
  (y1 (:pointer :float) :direction :output)
  (x2 (:pointer :float) :direction :output)
  (y2 (:pointer :float) :direction :output))
