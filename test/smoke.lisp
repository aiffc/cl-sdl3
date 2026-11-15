;;; smoke tests: macro export behavior + raw bindings.
;;; No rove, fiveam or whatever; load :sdl3/tests and call (sdl3/smoke:run).

(defpackage :sdl3/smoke
  (:use #:cl)
  (:export #:run))

(in-package :sdl3/smoke)

(defvar *failures* 0)

(defun check (label ok)
  (if ok
      (format t "ok   ~a~%" label)
      (progn (incf *failures*)
             (format t "FAIL ~a~%" label))))

(defun run ()
  (setf *failures* 0)

  ;; #1: defwrap-fun exports the raw binding even when no wrapper is
  ;; generated. SDL_GetSurfaceColorKey is a wrapped function; its raw
  ;; binding must exist and be external.
  (check "%get-surface-color-key is fboundp"
         (fboundp 'sdl3:%get-surface-color-key))
  (check "%get-surface-color-key is exported"
         (multiple-value-bind (sym status)
             (find-symbol "%GET-SURFACE-COLOR-KEY" :sdl3)
           (and (eq sym 'sdl3:%get-surface-color-key)
                (eq status :external))))

  ;; regression guard: a defwrap-fun with TRANSLATE nil must still emit
  ;; the export. Expansion-only. No library symbols are resolved.
  (check "defwrap-fun expansion exports raw binding"
         (search "EXPORT"
                 (write-to-string
                  (macroexpand-1
                   '(sdl3::defwrap-fun "SDL_TestNoWrap" :void ())))))

  ;; #2: %free is bound, exported, and callable (NULL free is a no-op).
  (check "%free is fboundp" (fboundp 'sdl3:%free))
  (check "%free is exported"
         (eq (nth-value 1 (find-symbol "%FREE" :sdl3)) :external))
  (sdl3:%free (cffi:null-pointer))

  (if (zerop *failures*)
      (format t "all smoke tests passed~%")
      (error "sdl3/smoke: ~d failure(s)" *failures*))
  *failures*)
