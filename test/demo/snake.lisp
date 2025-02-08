(in-package #:sdl3.demo)

(defparameter *step-rate-in-ms* 125)
(defparameter *snake-block-size-in-pixels* 48)
(defparameter *snake-game-width* 10)
(defparameter *snake-game-height* 10)

(deftype cell-value ()
  `(member :empty :food :left :right :up :down))

(defclass game-state ()
  ((cells :accessor cells)
   (head-pos :accessor head-pos)
   (tail-pos :accessor tail-pos)
   (next-dir :accessor next-dir)
   (occupied-cells :initform 0 :accessor occupied-cells)))

(defun cell (cells pos)
  (aref cells (first pos) (second pos)))

(defun (setf cell) (newval cells pos)
  (setf (aref cells (first pos) (second pos)) newval))


(defun place-food (state)
  (with-slots (occupied-cells cells) state
    (unless (= occupied-cells (* *snake-game-height* *snake-game-width*))
      (loop for x = (random *snake-game-width*)
            for y = (random *snake-game-height*)
            when (eql (aref cells x y) :empty)
              do (return (setf (aref cells x y) :food))))))

(defun initialize-game-state (state)
  (with-slots (cells head-pos tail-pos next-dir occupied-cells) state
    (let* ((mid-x (floor *snake-game-width* 2))
           (mid-y (floor *snake-game-height* 2)))
      (setf head-pos (list mid-x mid-y)
            tail-pos (list (- mid-x 3) mid-y)
            next-dir :right
            cells (make-array (list *snake-game-width* *snake-game-height*)
                              :initial-element :empty
                              :element-type 'cell-value)
            occupied-cells 4)
      (loop for x from mid-x downto (- mid-x 3) do
        (setf (aref cells x mid-y) :right))
      (loop repeat 4 do (place-food state)))
    state))

(defun next-position (pos dir)
  (destructuring-bind (x y) pos
    (ecase dir
      (:right (values (mod (+ x 1) *snake-game-width*) y))
      (:left (values (mod (- x 1) *snake-game-width*) y))
      (:up (values x (mod (- y 1) *snake-game-height*)))
      (:down (values x (mod (+ y 1) *snake-game-height*))))))

(defun opposite-dir (dir)
  (ecase dir
    (:up :down)
    (:down :up)
    (:left :right)
    (:right :left)))

(defun game-step (state)
  (declare (optimize (debug 3)))
  (with-slots (cells head-pos tail-pos next-dir occupied-cells) state
    (when (eql (cell cells head-pos) (opposite-dir next-dir))
      (setf next-dir (cell cells head-pos)))
    (multiple-value-bind (x y) (next-position head-pos next-dir)
      (flet ((move-head ()
               (setf (aref cells (first head-pos) (second head-pos)) next-dir)
               (setf (first head-pos) x
                     (second head-pos) y)
               (setf (aref cells x y) next-dir))

             (move-tail ()
               (let ((tail-dir (cell cells tail-pos)))
                 (setf (cell cells tail-pos) :empty)
                 (multiple-value-bind (x y)
                     (next-position tail-pos tail-dir)
                   (setf (first tail-pos) x
                         (second tail-pos) y)))))

        (case (aref cells x y)
          (:empty
           (move-head)
           (move-tail))
          (:food
           (move-head)
           (place-food state)
           (incf occupied-cells))
          (t ;; collision with self
           (initialize-game-state state)))))))

(defclass app ()
  ((window :initarg :window :accessor window)
   (renderer :initarg :renderer :accessor renderer)
   (state :initarg :state :accessor state)
   (last-step :initarg :last-step :accessor last-step)))

(defparameter *app* nil)

(defun assert-ret (return-value)
  (when (null return-value)
    (error "Error: ~a" (sdl3:get-error))))

(defun init ()
  (assert-ret (sdl3:set-app-metadata "Example Snake game" "1.0" "com.example.Snake"))
  (loop for (key value) on (list sdl3:+app-url-string+  "https://examples.libsdl.org/SDL3/demo/01-snake/"
                                 sdl3:+app-creator-string+  "SDL team"
                                 sdl3:+app-copyright-string+  "Placed in the public domain"
                                 sdl3:+app-type-string+  "game")
          by #'cddr do
            (assert-ret (sdl3:set-app-metadata-property key value)))

  (assert-ret (sdl3:init :video))

  ;; Destroy old windows
  ;; Useful during development where old crashed windows need cleanup
  (loop for window in (sdl3:get-windows)
        for renderer = (sdl3:get-renderer window)
        unless (or (cffi:null-pointer-p window)
                   (cffi:null-pointer-p renderer))
          do (assert-ret (sdl3:destroy-renderer renderer))
             (assert-ret (sdl3:destroy-window window)))

  (multiple-value-bind (ret window renderer)
      (sdl3:create-window-and-renderer
       "test/demo/snake"
       (* *snake-block-size-in-pixels* *snake-game-width*)
       (* *snake-block-size-in-pixels* *snake-game-height*)
       nil)
    (assert-ret ret)

    (setf *app* (make-instance 'app
                               :window window
                               :renderer renderer
                               :state (initialize-game-state (make-instance 'game-state))
                               :last-step (sdl3:get-ticks))))
  :continue)

(defun handle-event (type pevent)
  (cond ((eql type :quit)
         :success)
        ((eql type :key-down)
         (let* ((keyboard-event (cffi:mem-ref pevent '(:struct sdl3:keyboard-event)))
                (key (slot-value keyboard-event 'sdl3:%key))
                (scancode (slot-value keyboard-event 'sdl3:%scancode)))
           (when (member key '(:up :down :left :right))
             (setf (next-dir (state *app*)) key))
           (if (eql key :q)
               :success
               :continue)))
        (t :continue)))

(defun iterate ()
  (let ((now (sdl3:get-ticks))
        (rect (make-instance 'sdl3:frect
                             :%h (coerce *snake-block-size-in-pixels* 'float)
                             :%w (coerce *snake-block-size-in-pixels* 'float))))
    (with-slots (renderer last-step state) *app*
      (loop while (> (- now last-step)
                     *step-rate-in-ms*)
            do
               (incf last-step *step-rate-in-ms*)
               (game-step state))
      (when (< (- now last-step) *step-rate-in-ms*)
        (sleep (/ (- now last-step) 1000 5)))
      (sdl3:set-render-draw-color renderer 0 0 0 255)
      (sdl3:render-clear renderer)

      (flet ((fill-rect (x y r g b)
               (sdl3:set-render-draw-color renderer r g b 255)
               (setf (slot-value rect 'sdl3:%x) (* 1.0 x *snake-block-size-in-pixels*)
                     (slot-value rect 'sdl3:%y) (* 1.0 y *snake-block-size-in-pixels*))
               (sdl3:render-fill-rect renderer rect)))
        (loop for x from 0 below *snake-game-width* do
          (loop for y from 0 below *snake-game-height*
                for cell = (aref (cells state) x y) do
                  (case cell
                    (:empty
                     t)
                    (:food
                     (fill-rect x y 80 80 255))
                    (t
                     (fill-rect x y 0 128 0)))))

        (destructuring-bind (x y) (head-pos state)
          (fill-rect x y 255 255 0))
        (sdl3:render-present renderer)))
    :continue))

(defun handle-quit ()
  (sdl3:destroy-renderer (renderer *app*))
  (sdl3:destroy-window (window *app*))
  (sdl3:pump-events)
  (sdl3:quit-sub-system :video)
  (sdl3:quit))

;;;;; Example of how to run app by writing you own event and ui loop
(defun run-snake% ()
  (init)
  (unwind-protect
       (cffi:with-foreign-object (pevent '(:union sdl3:event))
         (loop named outer do
           (loop named event-loop
                 while (sdl3:poll-event pevent)
                 do
                    (let* ((type (cffi:mem-ref pevent :uint32))
                           (type-keyword (cffi:foreign-enum-keyword 'sdl3:event-type type))
                           (next (handle-event type-keyword pevent)))
                      (unless (eql next :continue)
                        (return-from outer))))
           (iterate)))
    (handle-quit)))

(defun do-snake-demo ()
  #+darwin
  (progn
    (trivial-main-thread:with-body-in-main-thread (:blocking t)
      (float-features:with-float-traps-masked t
        (run-snake%))))
  #-darwin
  (run-snake%))
(export 'do-snake-demo)

;;;;; Example of how to run app using SDL's new callback api

(sdl3:def-app-init demo-init (argc argv)
  (declare (ignore argc argv))
  (init))

(sdl3:def-app-iterate demo-iterate ()
  (iterate))

(sdl3:def-app-event demo-event (type event)
  (handle-event type event))

(sdl3:def-app-quit demo-quit (result)
  (declare (ignore result))
  (handle-quit))

(defun do-snake-demo2 ()
  (sdl3:enter-app-main-callbacks 'demo-init 'demo-iterate 'demo-event 'demo-quit))
(export 'do-snake-demo2)

