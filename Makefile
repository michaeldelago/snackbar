clean:
	rm -rf ./snackbar

run:
	sbcl --non-interactive \
			 --eval "(ql:quickload 'asdf)" \
			 --eval '(asdf:load-asd	"$(PWD)/snackbar.asd")' \
			 --eval '(ql:quickload :snackbar)' \
			 --eval '(snackbar:print-status)'

test:
	sbcl --non-interactive \
			 --load snackbar.asd \
	     --eval '(ql:quickload :snackbar/tests)' \
			 --eval '(asdf:test-system :snackbar)' \

build: clean
	sbcl --non-interactive \
	  	 --eval "(ql:quickload 'asdf)" \
			 --eval '(asdf:load-asd "$(PWD)/snackbar.asd")' \
			 --eval '(ql:quickload :snackbar/build)' \
			 --eval '(asdf:make :snackbar/build)'

shell:
	rlwrap sbcl --eval "(ql:quickload 'asdf)" \
				      --eval '(asdf:load-asd "$(PWD)/snackbar.asd")' \
              --eval '(ql:quickload :snackbar)'
