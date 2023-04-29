(defsystem "snackbar"
  :version "0.2.1"
  :author "michaeldelago"
  :license "MIT"
  :depends-on ("alexandria" 
               "cffi"
               "cl-autowrap"
               "cl-diskspace" 
               "cl-ppcre" 
               "local-time" 
               "split-sequence"
               "unix-opts")
  :pathname "src/"
  :serial t
  :components ((:file "helpers")
               (:file "config")
               (:file "package")
               (:file "cli")
               (:file "autowrap")
               (:file "main")
               (:file "audio")
               (:file "battery")
               (:file "disk")
               (:file "memory")
               (:file "time")
               (:file "load")
               (:module #:spec
                :pathname "spec"
                :components ()))
  :description "basic snackbar for sway")

(defsystem "snackbar/build"
  :depends-on ("snackbar")
  :build-operation program-op
  :build-pathname "_build/snackbar"
  :entry-point "snackbar.cli:main")
