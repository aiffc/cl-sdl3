;;;;
;; Command line tool to extract documentation (function and strcut/enum/union)
;; from header files packaged with SDL3
;;;;
(require 'cl-ppcre)
(require 'uiop)

(defparameter *docstrings* (make-hash-table :test 'equalp))
(defconstant +c-identifier-regex+ "[a-zA-Z_][a-zA-Z0-9_]*")

(defun cleanup-documentation (docstring)
  "Remove * at the start of each line and remove and one whitespace character"
  (with-output-to-string (stream)
    (cl-ppcre:do-register-groups (_ docline)
        ("( *\\* ?)(.*)" docstring)
      (declare (ignore _))
      (write-line (or docline "") stream))))

(defun get-match (regex string)
  (multiple-value-bind (_ matches)
      (cl-ppcre:scan-to-strings regex string)
    (declare (ignore _))
    (when matches
      (aref matches 0))))

(defparameter *enum-declaration*
  `(:sequence
    (:non-greedy-repetition 0 nil :everything)
    (:register (:regex ,+c-identifier-regex+))
    "(" (:non-greedy-repetition 0 nil :everything) ")"))

(defun parse-declaration (declaration)
  (loop for (type regex) on `(:function
                              (:sequence
                               (:non-greedy-repetition 0 nil :everything)
                               (:register (:regex ,+c-identifier-regex+))
                               "(" (:non-greedy-repetition 0 nil :everything)
                               (:alternation ")" "," :end-anchor))

                              :enum
                              (:sequence
                               "typedef enum "
                               (:register (:regex ,+c-identifier-regex+)))

                              :bitfield
                              (:sequence
                               (:alternation "typedef Uint64 " "typedef Uint32 ")
                               (:register (:regex ,+c-identifier-regex+)))

                              :struct
                              (:sequence
                               (:alternation "typedef struct " "struct ")
                               (:register (:regex ,+c-identifier-regex+)))

                              :typedef
                              (:sequence
                               "typedef"
                               (:non-greedy-repetition 0 nil :everything)
                               (:register (:regex ,+c-identifier-regex+))
                               (:non-greedy-repetition 0 nil :whitespace-char-class)
                               ";"))
          by #'cddr do
            (let ((identifier (get-match regex declaration)))
              (when identifier
                (return (list type identifier))))))

(defparameter *documentation-regex*
  ;; (cl-ppcre:parse-string "\\/\\*\\*\\s([\\s\\S]*?)\\*\\/\\s(.*)")
  '(:SEQUENCE "/**" :WHITESPACE-CHAR-CLASS
    (:REGISTER
     (:NON-GREEDY-REPETITION 0 NIL
      (:CHAR-CLASS :WHITESPACE-CHAR-CLASS :NON-WHITESPACE-CHAR-CLASS)))
    "*/" :WHITESPACE-CHAR-CLASS
    (:REGISTER (:GREEDY-REPETITION 0 NIL :EVERYTHING))))

(defun process-header (file)
  (let ((content (uiop:read-file-string file)))
    (cl-ppcre:do-register-groups (documentation declaration)
        (*documentation-regex* content)
      (setf documentation (cleanup-documentation documentation))
      (let ((parsed (parse-declaration declaration)))
        (if parsed
            (setf (gethash parsed *docstrings*) documentation)
            (format t "Ignored: ~a ~%" declaration))))))

(defun main (header-dir savefile)
  (loop for file in (uiop:directory-files header-dir)
        do
           (format t "Processing ~a~%" file)
           (process-header file))
  (with-open-file (stream savefile :direction :output :if-exists :supersede)
    (maphash (lambda (key value)
               (destructuring-bind (type identifier) key
                 (write (list type identifier value) :stream stream)
                 (write-char #\Newline stream)))
             *docstrings*)))

(defun run (&optional (args (uiop:command-line-arguments)))
  (let ((path (or (first args)
                  "/usr/local/include/SDL3/")))
    (unless (and (uiop:directory-pathname-p path)
                 (probe-file path))
      (error "SDL3 include (~a) path is invalid" path))
    (let ((savefile (or (second args)
                        "./docstrings.lisp")))
      (main path savefile))))
