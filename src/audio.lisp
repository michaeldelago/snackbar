(in-package :statusbar)

(defun get-audio ()
  (let* ((vol-ptrn "\\[([0-9]{1,3})%\\]")
         (mute-ptrn "\\[(on|off)\\]")
         (raw-output (uiop:run-program (list "amixer" "sget" "Master") :output :string))
         (volume (ppcre:register-groups-bind (first) (vol-ptrn raw-output) (list first)))
         (mute (ppcre:register-groups-bind (first) (mute-ptrn raw-output) (list first))))
    (list :VOLUME (first volume) :MUTE (equal (first mute) "off"))))

(defun format-audio (audio)
  (let ((icon (if (getf audio :MUTE)
                  "🔇"
                  #\SPEAKER)))
    (format nil "~d ~d%" icon (getf audio :VOLUME))))