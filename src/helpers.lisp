(uiop:define-package snackbar.helpers
  (:use :cl)
  (:export #:defstruct-exp))
(in-package :snackbar.helpers)
(defmacro defstruct-exp (structure specials &rest members)
  "Define a structure STRUCT with members MEMBERS and export the
  standard functions created. SPECIALS is a list of extra parameters eg
  ((:print-function pf)). Note double parentheses."
  (append
    `(progn
       ,(append `(defstruct ,(append `(,structure) specials)) members)
       ,`(export ,`(quote ,(intern (concatenate 'string "MAKE-" (symbol-name structure)))))
       ,`(export ,`(quote ,(intern (concatenate 'string "COPY-" (symbol-name structure))))))
    (mapcar
      #'(lambda (member)
          `(export ,`(quote ,(intern (concatenate 'string(symbol-name structure) "-" (symbol-name (if (symbolp member) member (car member))))))))
      members)))
