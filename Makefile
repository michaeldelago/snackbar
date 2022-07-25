swayconfigdir := $(HOME)/.config/sway/statusbar

clean:
	rm -rf build/*

run:
	sbcl --non-interactive \
			 --eval "(ql:quickload 'asdf)" \
			 --eval '(asdf:load-asd	"$(PWD)/statusbar.asd")' \
			 --eval '(ql:quickload :statusbar)' \
			 --eval '(statusbar:print-status)'

build: clean
	mkdir -pv build
	sbcl --load statusbar.asd \
	     --eval '(ql:quickload :statusbar)' \
       --eval "(sb-ext:save-lisp-and-die #p\"build/statusbar\" :toplevel #'statusbar:print-status :executable t)"

test:
	sbcl --non-interactive \
			 --load statusbar.asd \
	     --eval '(ql:quickload :statusbar/tests)' \
			 --eval '(asdf:test-system :statusbar)' \


install: test build
	cp ./build/statusbar $(swayconfigdir)

asdf:
	sbcl --non-interactive \
	  	 --eval "(ql:quickload 'asdf)" \
			 --eval '(asdf:load-asd "$(PWD)/statusbar.asd")' \
			 --eval '(asdf:make :statusbar)'