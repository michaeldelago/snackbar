(defpackage statusbar/tests/main
  (:use :cl
        :statusbar
        :rove))
(in-package :statusbar/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :statusbar)' in your Lisp.

(deftest show-status
  (testing "doesn't error out"
    (ok (statusbar:print-status))))
