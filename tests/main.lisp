(defpackage snackbar/tests/main
  (:use :cl
        :snackbar
        :rove))
(in-package :snackbar/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :snackbar)' in your Lisp.

(deftest show-status
  (testing "doesn't error out"
    (ok (snackbar:print-status))))
