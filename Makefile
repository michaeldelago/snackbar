swayconfigdir := $(HOME)/.config/sway/statusbar


build:
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