(in-package :sdl3)

(defexport-fun ("SDL_RectToFRect" rect-to-frect) :void
  (rect (:pointer (:struct rect)))
  (frect (:pointer (:struct frect))))

(defexport-fun "SDL_PointInRect" :bool
  (point (:pointer (:struct point)))
  (rect (:pointer (:struct rect))))

(defexport-fun "SDL_RectEmpty" :bool
  (rect (:pointer (:struct rect))))

(defexport-fun "SDL_RectsEqual" :bool
  (a (:pointer (:struct rect)))
  (b (:pointer (:struct rect))))

(defexport-fun "SDL_HasRectIntersection" :bool
  (a (:pointer (:struct rect)))
  (b (:pointer (:struct rect))))

(defexport-fun "SDL_GetRectIntersection" :bool
  (a (:pointer (:struct rect)))
  (b (:pointer (:struct rect)))
  (ret (:pointer (:struct rect))))

(defexport-fun "SDL_GetRectUnion" :bool
  (a (:pointer (:struct rect)))
  (b (:pointer (:struct rect)))
  (ret (:pointer (:struct rect))))

(defexport-fun "SDL_GetRectEnclosingPoints" :bool
  (point (:pointer (:struct point)))
  (count :int)
  (clip (:pointer (:struct rect)))
  (ret (:pointer (:struct rect))))

(defexport-fun "SDL_GetRectAndLineIntersection" :bool
  (rect (:pointer (:struct rect)))
  (x1 (:pointer :int))
  (y1 (:pointer :int))
  (x2 (:pointer :int))
  (y2 (:pointer :int)))

(defexport-fun "SDL_PointInRectFloat" :bool
  (point (:pointer (:struct fpoint)))
  (rect (:pointer (:struct frect))))

(defexport-fun "SDL_RectEmptyFloat" :bool
  (rect (:pointer (:struct frect))))

(defexport-fun "SDL_RectsEqualEpsilon" :bool
  (a (:pointer (:struct frect)))
  (b (:pointer (:struct frect)))
  (epsilon :float))

(defexport-fun "SDL_RectsEqualFloat" :bool
  (a (:pointer (:struct frect)))
  (b (:pointer (:struct frect))))

(defexport-fun "SDL_HasRectIntersectionFloat" :bool
  (a (:pointer (:struct frect)))
  (b (:pointer (:struct frect))))

(defexport-fun "SDL_GetRectIntersectionFloat" :bool
  (a (:pointer (:struct frect)))
  (b (:pointer (:struct frect)))
  (ret (:pointer (:struct frect))))

(defexport-fun "SDL_GetRectUnionFloat" :bool
  (a (:pointer (:struct frect)))
  (b (:pointer (:struct frect)))
  (ret (:pointer (:struct frect))))

(defexport-fun "SDL_GetRectEnclosingPointsFloat" :bool
  (point (:pointer (:struct fpoint)))
  (count :int)
  (clip (:pointer (:struct frect)))
  (ret (:pointer (:struct frect))))

(defexport-fun "SDL_GetRectAndLineIntersectionFloat" :bool
  (rect (:pointer (:struct frect)))
  (x1 (:pointer :float))
  (y1 (:pointer :float))
  (x2 (:pointer :float))
  (y2 (:pointer :float)))
