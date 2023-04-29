NAME:=_build/snackbar
LISP:=qlot exec ros run
PREFIX:=$(HOME)/bin

build: clean
	$(LISP) \
	  --eval "(ql:quickload 'asdf)" \
		--eval '(asdf:load-asd "$(PWD)/snackbar.asd")' \
		--eval '(ql:quickload :snackbar/build)' \
		--eval '(asdf:make :snackbar/build)' \
		--quit

install: build
	mv $(NAME) $(PREFIX)/$(NAME)

clean:
	rm -rf ./$(NAME)

run:
	$(LISP) -- --non-interactive \
	  --eval "(ql:quickload 'asdf)" \
	  --eval '(asdf:load-asd	"$(PWD)/snackbar.asd")' \
	  --eval '(ql:quickload :snackbar)' \
	  --eval '(snackbar:print-status)' \
	  --quit

test:
	$(LISP) --non-interactive \
		--load snackbar.asd \
	  --eval '(ql:quickload :snackbar/tests)' \
		--eval '(asdf:test-system :snackbar)' \
		--quit

shell:
	rlwrap sbcl --eval "(ql:quickload 'asdf)" \
		--eval '(asdf:load-asd "$(PWD)/snackbar.asd")' \
    --eval '(ql:quickload :snackbar)'
