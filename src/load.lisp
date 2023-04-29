(in-package :snackbar)

(defun get-load-avg ()
  (autowrap:with-calloc (loadavg :double 3)
      (if (> (getloadavg loadavg 3) -1)
          (map 'list (lambda (pos) (autowrap:c-aref loadavg pos :double))
               (alexandria:iota 3))
          '(-1.0 -1.0 -1.0))))

(defun 1-min-avg ()
  (nth 0 (get-load-avg)))

(defun 5-min-avg ()
  (nth 1 (get-load-avg)))

(defun 15-min-avg ()
  (nth 2 (get-load-avg)))

(defun format-load (load-values)
  (format nil "~{~,2F~^ ~}" load-values))
