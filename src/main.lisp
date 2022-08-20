(in-package :statusbar)

(defun print-status ()
  (progn
   (let ((avg-load  (format-load (list (1-min-avg))))
         (memory    (format-memory (get-memory-info)))
         (disks     (format-disks (get-disks)))
         (audio     (format-audio (get-audio)))
         (battery   (format-battery (mapcar #'get-battery-stats (get-battery))))
         (clock     (get-time)))
     (princ 
       (format nil "~{~A ~^| ~}" 
         (remove-if (lambda (stat) (equal stat "")) 
             (list avg-load memory disks audio battery clock)))))
   t))