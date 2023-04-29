(uiop:define-package snackbar.config
  (:use :cl)
  (:export #:*config*
   #:save-default-config
   #:load-config)
  (:import-from :snackbar.helpers #:defstruct-exp))
(in-package :snackbar.config)

(defun list-of-strings-p (list)
  (and (consp list) (every #'stringp list)))

(deftype list-of-strings ()
  `(satisfies list-of-strings-p))

(defstruct-exp configuration ()
  (disk (make-disk))
  (battery (make-battery)))

(defstruct-exp disk ()
  (blocked-disks (list "/boot" "/boot/efi") :type list-of-strings))

(defstruct-exp battery ()
  (power-supply-path "/sys/class/power_supply"))

(defparameter *xdg-config-home* 
  (or (uiop:getenv-absolute-directory "XDG_CONFIG_HOME")
      (pathname (uiop:native-namestring "~/.config/"))))

;; Config is search for in 3 locations
;; 
;; 1. $SNACKBAR_CONFIG
;; 2. $XDG_CONFIG_HOME/snackbar/config
;; 3. $XDG_CONFIG_HOME/sway/snackbar
;; 4. $XDG_CONFIG_HOME/i3/snackbar
;; 5. /etc/snackbar/config
(defparameter *config-locations*
  (list (uiop:getenv "SNACKBAR_CONFIG")
        (uiop:merge-pathnames* #P"snackbar/config" *xdg-config-home* )
        (uiop:merge-pathnames* #P"sway/snackbar" *xdg-config-home* )
        (uiop:merge-pathnames* #P"i3/snackbar" *xdg-config-home* )
        #P"/etc/snackbar/config"))

(defparameter *first-valid-config* 
  (dolist (f *config-locations*)
    (if (and f (probe-file f))
        (return f))))

(defun save-default-config (&optional output)
  "Print the current configuration to stdout"
  (let ((*print-pretty* t))
      (format (or output t) "~@S" (load-config))))

(defun load-config ()
  "Load a configuration or generate the default"
  (or
    (when (and *first-valid-config* (probe-file *first-valid-config*))
      (uiop:with-safe-io-syntax (:package :snackbar.config)
        (car (uiop:read-file-forms *first-valid-config*))))
    (make-configuration)))

(defparameter *config* (load-config))
