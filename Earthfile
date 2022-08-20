VERSION 0.6
FROM fukamachi/sbcl:2.2.6-debian
WORKDIR /snackbar
 
build:
    ARG TZ="America/New_York"
    RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
    RUN apt update && apt install -y build-essential
    COPY snackbar.asd .
    COPY src src
    RUN --mount=type=cache,target=/root/.cache/common-lisp \
          sbcl --non-interactive \
	  	       --eval "(ql:quickload 'asdf)" \
			   --eval '(asdf:load-asd "/snackbar/snackbar.asd")' \
			   --eval '(ql:quickload :snackbar/build)' \
			   --eval '(asdf:make :snackbar/build)'
    SAVE ARTIFACT snackbar AS LOCAL snackbar