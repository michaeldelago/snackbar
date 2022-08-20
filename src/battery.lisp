(in-package :statusbar)
(defparameter *power-supply-path* (pathname "/sys/class/power_supply/"))

(defun get-battery ()
  (remove-if-not (lambda (dir)
                   (equal (subseq (enough-namestring (pathname dir) *power-supply-path*) 0 3)
                          "BAT"))
      (uiop:subdirectories *power-supply-path*)))

(defun get-battery-stats (battery-path)
  (let ((energy-now (read-file-int #P"energy_now" battery-path))
        (energy-full (read-file-int #P"energy_full" battery-path)))
    (list :NAME (string-downcase (subseq (enough-namestring battery-path *power-supply-path*) 0 4))
          :STATUS (string-downcase (first (uiop:read-file-lines (merge-pathnames #P"status" battery-path))))
          :PERCENT (float (* 100 (/ energy-now energy-full))))))

(defun format-battery (batteries)
  (format nil "~{~d~^ | ~}"
    (mapcar
        (lambda (batt)
          (let ((icon (cond
                       ((equal (getf batt :STATUS) "discharging") "🔋⬇️")
                       ((equal (getf batt :STATUS) "not charging") "🔋⚡")
                       ((equal (getf batt :STATUS) "charging") "🔌")
                       (t ""))))
            (format nil "~d ~,1F% ~d" (getf batt :NAME) (getf batt :PERCENT) icon)))
        batteries)))

(defun read-file-int (file path)
  (parse-integer 
    (first 
    (uiop:read-file-lines 
      (merge-pathnames file path)))))