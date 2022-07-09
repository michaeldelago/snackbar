(in-package :statusbar)

(defparameter *blocked-disks* (list "/boot"))

(defun get-disks ()
  (remove-if (lambda (disk)
               (member (getf disk :DISK) *blocked-disks* :test #'equalp))
      (cl-diskspace:list-all-disk-info nil)))

(defun format-disks (disks)
  (let* ((out ()) (disks
                   (dolist (disk disks out)
                     (push (format nil "~d: ~d%" (getf disk :DISK) (getf disk :use-percent)) out))))
    (format nil "~{~A~^ ~}" disks)))
