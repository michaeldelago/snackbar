(import :asdf)
(asdf:defsystem "statusbar"
  :version "0.1.0"
  :author "michaeldelago"
  :license "MIT"
  :depends-on ("alexandria" "cl-ppcre" "local-time" "cl-diskspace")
  :pathname "src/"
  :components ((:file "main")
               (:file "audio")
               (:file "battery")
               (:file "disk")
               (:file "time")
               (:file "helpers"))
  :description "basic statusbar for sway"
  :in-order-to ((test-op (test-op "statusbar/tests")))
  :build-operation "program-op"
  :build-pathname "statusbar"
  :entry-point "main:print-status")

(asdf:defsystem "statusbar/tests"
  :depends-on ("statusbar"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for statusbar"
  :perform (asdf:test-op (op c) (uiop/package:symbol-call :rove '#:run c)))
