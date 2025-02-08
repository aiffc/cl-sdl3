(in-package #:sdl3)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun load-docstrings (docfile
                      &aux (sdl3-package (find-package :sdl3)))
    (let ((docstrings (uiop:read-file-forms docfile)))
      (loop for (type identifier docstring) in docstrings
            for symbol-name = (ignore-errors (string-upcase (sdl3::sdl->lsp identifier)))
            for symbol = (and symbol-name
                              (find-symbol symbol-name sdl3-package))
            do
               (cond ((null symbol))
                     ((eql type :function)
                      (when (fboundp symbol)
                        (setf (documentation symbol 'function) docstring)))
                     ((or (eql type :enum)
                          (eql type :bitfield)
                          (eql type :typedef))
                      (setf (get symbol :doc) docstring))
                     ((eql type :struct)
                      (setf (documentation symbol 'type) docstring))
                     (t
                      (format t "~a ~a~%" type symbol)
                      (setf (documentation symbol t) docstring)))))))

#-sdl3-nodoc
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load-docstrings (asdf:system-relative-pathname :sdl3 "doc/docstrings.lisp")))
