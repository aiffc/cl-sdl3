(in-package #:sdl3)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun load-docstrings (docfile package)
    (let ((docstrings (uiop:read-file-forms docfile)))
      (loop for (type identifier docstring) in docstrings
            for symbol-name = (ignore-errors (string-upcase (sdl3::sdl->lsp identifier)))
            for symbol = (and symbol-name
                              (find-symbol symbol-name package))
            do
               (cond ((null symbol))
                     ((eql type :function)
                      (when (fboundp symbol)
                        (setf (documentation symbol 'function) docstring)))
                     ((or (eql type :enum)
                          (eql type :bitfield)
                          (eql type :typedef))
                      (setf (documentation symbol 'type) docstring))
                     ((eql type :struct)
                      (setf (documentation symbol 'type) docstring))
                     (t
                      (format t "~a ~a~%" type symbol)
                      (setf (documentation symbol t) docstring)))))))

#-sdl3-nodoc
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load-docstrings (asdf:system-relative-pathname :sdl3 "doc/docstrings.lisp")
                   (find-package :sdl3))

  (load-docstrings (asdf:system-relative-pathname :sdl3 "doc/image_docstrings.lisp")
                   (find-package :sdl3-image))

  (load-docstrings (asdf:system-relative-pathname :sdl3 "doc/ttf_docstrings.lisp")
                   (find-package :sdl3-ttf)))
