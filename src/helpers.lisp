(in-package :statusbar)
(defun read-file-int (file path)
  (parse-integer 
    (first 
    (uiop:read-file-lines 
      (merge-pathnames file path)))))