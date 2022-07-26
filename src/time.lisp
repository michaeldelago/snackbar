(in-package :statusbar)

(progn
 (local-time:reread-timezone-repository)
 (setf local-time:*default-timezone* 
   (local-time:find-timezone-by-location-name (uiop/os:getenv "TZ"))))

(defun get-time ()
  (let ((fmt '(:short-weekday ", " :short-month " " (:day 2) " " :year " " :hour12 ":" (:min 2) " " :ampm)))
    (local-time:format-timestring nil (local-time:now) :format fmt)))