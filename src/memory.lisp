(in-package :snackbar)

(defvar *meminfo* #P"/proc/meminfo")

(defun get-memory-info ()
  (let ((out ()) (lines (uiop:read-file-lines *meminfo*)))
    (dolist (line lines out)
      (let* ((stat (split-line line))
             (k (read-from-string (first stat)))
             (v (parse-integer (second stat))))
        (push (cons k v) out)))
    out))

(defun format-memory (meminfo)
  (let ((avail (kb-to-gb (alexandria:assoc-value meminfo (find-symbol "MEMAVAILABLE"))))
        (percentage (float (* 100 (/ (alexandria:assoc-value meminfo (find-symbol "ACTIVE")) (alexandria:assoc-value meminfo (find-symbol "MEMTOTAL")))))))
    (format nil "avail: ~,1FG used: ~,1F%" avail percentage)))

(defun split-line (line)
  (split-sequence:split-sequence-if
    (lambda (item)
      (position item " :")) line :remove-empty-subseqs t))

(defun kb-to-gb (val)
 (float (/ (/ val 1024) 1024)))