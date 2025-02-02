(in-package :sdl3)

(defmacro def-audio-stream-callback (name (data stream additional-amount total-amount) &body body)
  `(cffi:defcallback ,name :void ((,data :pointer)
				  (,stream :pointer) 
				  (,additional-amount :int)
				  (,total-amount :int))
     ,@body))
(export 'def-audio-stream-callback)

(defun open-audio-device-stream (spec &key (did #xffffffff) (callback nil) (data nil))
  (cffi:with-foreign-objects ((%spec '(:struct audio-spec)))
    (unless (null spec)
      (setf (cffi:mem-ref %spec '(:struct audio-spec)) spec))
    (let ((sdl3::ret
	    (%open-audio-device-stream did
				       (if (null spec)
					   (cffi-sys:null-pointer)
					   %spec)
				       (if (null callback)
					   (cffi-sys:null-pointer)
					   (cffi:get-callback callback))
				       (if (null data)
					   (cffi-sys:null-pointer)
					   data))))
      (values sdl3::ret))))

(export 'open-audio-device-stream)
