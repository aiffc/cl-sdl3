(in-package :sdl3-ttf)

(cffi:defbitfield font-style-flags 
  (:normal        #x00)
  (:bold          #x01)
  (:italic        #x02)
  (:underline     #x04)
  (:strikethrough #x08))

(cffi:defcenum hinting-flags
  (:normal 0)
  :light
  :mono
  :none
  :light-subpixel)

(cffi:defcenum horizontal-alignment
  (:invalid -1)
  (:left)
  (:center)
  (:right))

(cffi:defcenum direction
 (:INVALID 0)
 (:LTR 4)
 :RTL
 :TTB
 :BTT)

(cffi:defcenum image-type
  (:INVALID)
  (:ALPHA)
  (:COLOR)
  (:SDF))

(sdl3::deflsp-type text
  (text :string)
  (num-line :int)
  (ref-count :int)
  (internal :pointer))

(cffi:defcstruct (gpu-atlas-draw-sequence :class c-gpu-atlas-draw-sequence)
  (atlas-texture :pointer)
  (xy (:pointer (:struct sdl3:fpoint)))
  (uv (:pointer (:struct sdl3:fpoint)))
  (num-vertices :int)
  (indices (:pointer :int))
  (num-indices :int)
  (image-type image-type)
  (next :pointer))

(defclass-std:defclass/std gpu-atlas-draw-sequence () ((%atlas-texture %xy %uv %num-vertices %indices %num-indices %image-type %next)))

(defmethod cffi:translate-into-foreign-memory (value (type c-gpu-atlas-draw-sequence) ptr)
  (cffi:with-foreign-slots ((atlas-texture
			     xy
			     uv
			     num-vertices
			     indices
			     num-indices
			     image-type
			     next)
			    ptr
			    (:struct gpu-atlas-draw-sequence))
    (with-slots (%atlas-texture 
		 %xy
		 %uv
		 %num-vertices
		 %indices
		 %num-indices
		 %image-type
		 %next)
	value
      (cffi:with-foreign-objects ((xy-ptr '(:struct sdl3:fpoint) %num-vertices)
				  (uv-ptr '(:struct sdl3:fpoint) %num-vertices)
				  (indices-ptr :int %num-indices))
	(dotimes (i %num-indices)
	  (setf (cffi:mem-aref indices-ptr :int i) (elt %indices i)))
	(dotimes (i %num-vertices)
	  (setf (cffi:mem-aref xy-ptr '(:struct sdl3:fpoint) i) (elt %xy i)
		(cffi:mem-aref uv-ptr '(:struct sdl3:fpoint) i) (elt %uv i)))
	(setf atlas-texture %atlas-texture
	      xy xy-ptr
	      uv uv-ptr
	      num-vertices %num-vertices
	      indices indices-ptr
	      image-type :image-type
	      next %next)))))


(defmethod cffi:translate-from-foreign (ptr (type c-gpu-atlas-draw-sequence))
  (cffi:with-foreign-slots ((atlas-texture
			     xy
			     uv
			     num-vertices
			     indices
			     num-indices
			     image-type
			     next)
			    ptr
			    (:struct gpu-atlas-draw-sequence))
    (make-instance 'gpu-atlas-draw-sequence
		   :%atlas-texture atlas-texture
		   :%xy (loop :for i :from 0 :below num-vertices
			      :collect (cffi:mem-aref xy '(:struct sdl3:fpoint) i))
		   :%uv (loop :for i :from 0 :below num-vertices
			      :collect (cffi:mem-aref uv '(:struct sdl3:fpoint) i))
		   :%num-vertices num-vertices
		   :%indices (loop :for i :from 0 :below num-indices 
				   :collect (cffi:mem-aref indices :int i))
		   :%num-indices num-indices 
		   :%image-type image-type
		   :%next next))) ;; don't translate nexit
(export '(animation %w %h %count %frames %delays))


(export '(gpu-atlas-draw-sequence %atlas-texture %xy %uv %num-vertices %indices %image-type %next))

(cffi:defcenum gpu-text-engine-winding
  (:invalid -1)
  :clockwise
  :counter-clockwise)

(cffi:defbitfield sub-string-flags
  (:direction-mask    #x000000ff)
  (:text-start        #x00000100)
  (:line-start        #x00000200)
  (:line-end          #x00000400)
  (:text-end          #x00000800))

(sdl3::deflsp-type sub-string
  (flags sub-string-flags)
  (offset :int)
  (length :int)
  (line-index :int)
  (cluster-index :int)
  (rect (:struct sdl3:rect)))
