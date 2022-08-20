(in-package :snackbar)

;; int getloadavg(double loadavg[], int nelem);
(defcfun ("getloadavg" %getloadavg) :int
         (loadavg (:pointer :double))
         (nelem :int))

(defun get-load-avg ()
  (with-foreign-pointer (loadavg 3)
    (progn 
      (if (> (%getloadavg loadavg 3) -1)
        (map 'list 
        #'(lambda (pos) (mem-aref loadavg :double pos))  
        (alexandria:iota 3))
        '(-1.0)))))

(defun 1-min-avg ()
  (nth 0 (get-load-avg)))

(defun 5-min-avg ()
  (nth 1 (get-load-avg)))

(defun 15-min-avg ()
  (nth 2 (get-load-avg)))

(defun format-load (load-values)
  (format nil "~{~,2F~^ ~}" load-values))