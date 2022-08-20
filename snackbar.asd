(defsystem "snackbar"
  :version "0.2"
  :author "michaeldelago"
  :license "MIT"
  :defsystem-depends-on ("cffi-grovel")
  :depends-on ("alexandria" "cl-ppcre" "local-time" "cl-diskspace" "split-sequence" "cffi")
  :pathname "src/"
  :serial t
  :components ((:file "package")
               (:file "main")
               (:file "audio")
               (:file "battery")
               (:file "disk")
               (:file "memory")
               (:file "time")
               (:cffi-grovel-file "grovel-stdlib")
               (:file "load"))
  :description "basic snackbar for sway")

(defsystem "snackbar/build"
  :depends-on ("snackbar")
  :build-operation program-op
  :build-pathname "snackbar"
  :entry-point "snackbar:print-status")