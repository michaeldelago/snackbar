clean:
	rm -rf ./statusbar

run:
	sbcl --non-interactive \
			 --eval "(ql:quickload 'asdf)" \
			 --eval '(asdf:load-asd	"$(PWD)/statusbar.asd")' \
			 --eval '(ql:quickload :statusbar)' \
			 --eval '(statusbar:print-status)'

test:
	sbcl --non-interactive \
			 --load statusbar.asd \
	     --eval '(ql:quickload :statusbar/tests)' \
			 --eval '(asdf:test-system :statusbar)' \

build: clean
	sbcl --non-interactive \
	  	 --eval "(ql:quickload 'asdf)" \
			 --eval '(asdf:load-asd "$(PWD)/statusbar.asd")' \
			 --eval '(ql:quickload :statusbar)' \
			 --eval '(asdf:make :statusbar)'

shell:
	rlwrap sbcl --eval "(ql:quickload 'asdf)" \
				      --eval '(asdf:load-asd "$(PWD)/statusbar.asd")' \
              --eval '(ql:quickload :statusbar)'
