(in-package :statusbar)

(defparameter *blocked-disks* (list "/boot" "/boot/efi"))

(defun get-disks ()
  (remove-if (lambda (disk)
               (member (getf disk :DISK) *blocked-disks* :test #'equalp))
      (cl-diskspace:list-all-disk-info nil)))

(defun format-disks (disks)
  (let* ((out ())
         (disks
          (dolist (disk disks out)
            (push (format nil "~d: ~d% avail: ~,1FG" (getf disk :DISK) 
                                                     (getf disk :use-percent) 
                                                     (byte-to-gb (getf disk :available))) 
                  out))))
    (format nil "~{~A~^ |~}" disks)))

;; val * (1 / 1024)^3
(defun byte-to-gb (val)
  (float (/ (/ (/ val 1024) 1024) 1024)))