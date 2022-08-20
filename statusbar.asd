(defsystem "statusbar"
  :version "0.1.0"
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
  :description "basic statusbar for sway")

(defsystem "statusbar/build"
  :depends-on ("statusbar")
  :build-operation program-op
  :build-pathname "statusbar"
  :entry-point "statusbar:print-status")