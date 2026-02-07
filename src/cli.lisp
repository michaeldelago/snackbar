(uiop:define-package snackbar.cli
  (:use :cl)
  (:export #:main))
(in-package :snackbar.cli)

(defparameter *system-name-base* "snackbar")

(opts:define-opts
  (:name :help
   :description "display this help text"
   :short #\h
   :long "help")
  (:name :show-config
   :description "show configuration"
   :short #\s
   :long "show-config")
  (:name :loop
   :description "loop and print on a single line"
   :short #\l
   :long "loop")
  (:name :tz
   :description "your timezone, if your machine doesn't use the local timezone. example `--tz -5` for US/Eastern"
   :arg-parser (lambda (zone) (- (parse-integer zone)))
   :long "tz"))

(defmacro when-option ((options opt) &body body)
  `(let ((it (getf ,options ,opt)))
     (when it
       ,@body)))

(defun unknown-option (condition)
  (format t "warning: ~s option is unknown~%" (opts:option condition))
  (invoke-restart 'opts:skip-option))

(defun missing-option (condition)
  (declare (ignore condition))
  (invoke-restart 'opts:use-value '(EMPTY)))

(defun main ()
  (multiple-value-bind (options)
      (handler-case
          (handler-bind ((opts:unknown-option #'unknown-option)
                         (opts:missing-required-option #'missing-option))
            (opts:get-opts (uiop:command-line-arguments)))
        (opts:missing-arg (condition)
          (format t "fatal: option ~s needs an argument~%" (opts:option condition))
          (opts:exit 1))
        (opts:arg-parser-failed (condition)
          (format t "fatal: cannot parse ~s as argument of ~s~%"
                  (opts:raw-arg condition)
                  (opts:option condition))
          (opts:exit 1)))
    (when-option (options :help)
      (opts:describe :usage-of "snackbar")
      (opts:exit 0))
    (when-option (options :show-config)
      (snackbar.config:save-default-config t)
      (opts:exit 0))
    (when-option (options :loop)
      (loop (snackbar:print-status)
            (format t "~C" #\return)
            (finish-output)
            (sleep 1)))
    (snackbar:print-status)
    (opts:exit 0)))
