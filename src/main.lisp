(defpackage statusbar
  (:use :cl)
  (:export #:print-status))
(in-package :statusbar)

(defun print-status ()
  (progn
   (princ (format nil "~d | ~d | ~d | ~d ~%" (format-disks (get-disks)) (format-audio (get-audio)) (format-battery (mapcar #'get-battery-stats (get-battery))) (get-time)))
   t))