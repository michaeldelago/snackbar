(in-package :snackbar)

(progn
 (local-time:reread-timezone-repository)
 (setf *tz* 
   (local-time:find-timezone-by-location-name (uiop/os:getenv "TZ"))))

(defun get-time ()
  (let ((fmt '(:short-weekday ", " :short-month " " (:day 2) " " :year " " :hour12 ":" (:min 2) " " :ampm))
        (tz (or (local-time:find-timezone-by-location-name (uiop/os:getenv "TZ")) local-time:*default-timezone*)))
    (local-time:format-timestring nil (local-time:now) :format fmt :timezone tz)))