(in-package :sdl3-image)

(cffi:defcstruct (animation :class c-animation)
  (w :int)
  (h :int)
  (count :int)
  (frames (:pointer (:pointer (:struct sdl3:surface))))
  (delays (:pointer :int)))

(defclass-std:defclass/std animation () ((%w %h %count %frames %delays)))

(defmethod cffi:translate-into-foreign-memory (value (type c-animation) ptr)
  (cffi:with-foreign-slots ((w h count frames delays) ptr (:struct animation))
    (with-slots (%w %h %count %frames %delays) value
      (cffi:with-foreign-objects ((frame-ptr '(:pointer (:struct sdl3::surface)) %count)
				  (delay-ptr :int %count))
	(dotimes (i count)
	  (setf (cffi:mem-aref frames '(:pointer (:struct sdl3::surface)) i) (elt %frames i)
		(cffi:mem-aref frames :int i) (elt %delays i)))
	(setf w %w
	      w %h
	      count %count)))))


(defmethod cffi:translate-from-foreign (ptr (type c-animation))
  (cffi:with-foreign-slots ((w h count frames delays) ptr (:struct animation))
    (make-instance 'animation
		   :%w w
		   :%h h
		   :%count  count
		   :%frames (loop :for i :from 0 :below count
				  :collect (cffi:mem-aref frames
							  '(:pointer (:struct sdl3:surface))
							  i))
		   :%delays (loop :for i :from 0 :below count
				  :collect (cffi:mem-aref frames delays i)))))
(export '(animation %w %h %count %frames %delays))
