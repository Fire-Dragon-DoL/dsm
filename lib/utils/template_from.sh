#!/bin/bash

# $1 template_file
# $2 target_file
dsm_template_from() {
  eval "cat >$2 <<EOF
$(<$1)
EOF
" 2> /dev/null
}
