(in-package :sdl3.demo.menu)

(declaim (special *status-message-classes*))

(defun handle-action-quit (action label)
  (declare (ignore action label))
  :success)

(defun handle-action-open (action label)
  (declare (ignore action))
  (setf *status-message-classes* (format nil "Opening '~a'..." label))
  :continue)

(defun handle-action-preferences (action label)
  (declare (ignore action))
  (setf *status-message-classes* (format nil "Preferences requested: ~a" label))
  :continue)

(defparameter *action-handlers* (make-hash-table :test #'eq))

(defun register-action-handler (action handler)
  (setf (gethash action *action-handlers*) handler))

(defun unregister-action-handler (action)
  (remhash action *action-handlers*))

(defun initialize-default-action-handlers ()
  (clrhash *action-handlers*)
  (register-action-handler :quit #'handle-action-quit)
  (register-action-handler :open #'handle-action-open)
  (register-action-handler :preferences #'handle-action-preferences)
  *action-handlers*)

(defun reset-action-handlers ()
  (initialize-default-action-handlers))

(initialize-default-action-handlers)

(defun execute-command-action (action label)
  (let ((handler (and (symbolp action)
                      (gethash action *action-handlers*))))
    (setf *status-message-classes* (format nil "Action: ~a" label))
    (format t "screen menu class action: ~a (~a)~%" label action)
    (if handler
        (funcall handler action label)
        :continue)))
