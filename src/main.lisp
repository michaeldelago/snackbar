(defpackage statusbar
  (:use :cl)
  (:export #:print-status))
(in-package :statusbar)

(defun print-status ()
  (progn
   (let ((memory  (format-memory (get-memory-info)))
         (disks   (format-disks (get-disks)))
         (audio   (format-audio (get-audio)))
         (battery (format-battery (mapcar #'get-battery-stats (get-battery))))
         (clock   (get-time)))
     (princ
       (format nil "~d | ~d | ~d | ~d | ~d ~%"
         memory disks audio battery clock)))
   t))