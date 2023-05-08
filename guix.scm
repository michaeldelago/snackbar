(use-modules (guix packages)
             (guix gexp)
             (guix git-download)
             (guix build-system asdf)
             (guix build utils)
             (guix licenses)
             (ice-9 popen)
             (ice-9 rdelim)
             (gnu packages gawk)
             (gnu packages gcc)
             (gnu packages lisp)
             (gnu packages linux)
             (gnu packages lisp-xyz))

(define %source-dir 
  (dirname (current-filename)))

(define (git-output . args)
  "Execute `git` and return stdout"
  (with-directory-excursion 
    %source-dir
    (let* ((port (apply open-pipe* OPEN_READ "git" args))
           (output (read-string port)))
      (close-pipe port)
      (string-trim-right output #\newline))))

(define (git-sha)
  (git-output "rev-parse" "HEAD"))

(define sbcl-snackbar
  (let ((commit (git-sha)))
  (package 
    (name "snackbar")
    (synopsis "Statusbar for sway and i3")
    (description "Statusbar for sway and i3")
    (license expat)
    (home-page "github.com/michaeldelago/snackbar")
    (version (string-take commit 7))
    (source (local-file %source-dir
                        #:recursive? #t
                        #:select? (git-predicate %source-dir)))
    (build-system asdf-build-system/sbcl)
    (native-inputs (list 
      sbcl 
      sbcl-cffi 
      cl-alexandria 
      cl-ppcre 
      cl-local-time 
      cl-split-sequence
      cl-diskspace
      cl-autowrap
      cl-unix-opts
      gcc))
    (inputs (list alsa-utils))
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'create-asdf-configuration 'build-program
            (lambda* (#:key outputs #:allow-other-keys)
              (build-program
               (string-append (assoc-ref outputs "out") "/bin/snackbar")
               outputs
               #:entry-program '((snackbar.cli:main) 0))))))))))

sbcl-snackbar
