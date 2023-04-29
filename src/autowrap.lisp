(in-package :snackbar)

(autowrap:c-include "/usr/include/stdlib.h"
                    :spec-path '(snackbar spec)
                    :exclude-definitions ("^.*$")
                    :include-definitions ("getloadavg"))
