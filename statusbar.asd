(defsystem "statusbar"
  :version "0.1.0"
  :author "michaeldelago"
  :license "MIT"
  :depends-on ("alexandria" "cl-ppcre" "local-time" "cl-diskspace" "split-sequence")
  :pathname "src/"
  :components ((:file "main")
               (:file "audio")
               (:file "battery")
               (:file "disk")
               (:file "memory")
               (:file "time")
               (:file "helpers"))
  :description "basic statusbar for sway"
  :build-operation "program-op"
  :build-pathname "statusbar"
  :entry-point "statusbar:print-status")