VERSION 0.6
FROM fukamachi/sbcl:2.2.6-debian
WORKDIR /statusbar
 
build:
    ARG TZ="America/New_York"
    RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
    RUN apt update && apt install -y build-essential
    COPY statusbar.asd .
    COPY src src
    RUN --mount=type=cache,target=/root/.cache/common-lisp \
          sbcl --non-interactive \
             --load statusbar.asd \
             --eval '(ql:quickload :statusbar)' \
             --eval "(sb-ext:save-lisp-and-die #p\"statusbar\" :toplevel #'statusbar:print-status :executable t)"
    SAVE ARTIFACT statusbar AS LOCAL build/statusbar