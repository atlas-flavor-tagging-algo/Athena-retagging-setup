#!/usr/bin/env bash
#
# submit jobs for h->bb studies

set -eu

SCRIPT_DIR=$(dirname $BASH_SOURCE)

OPTS=" -j jobOptions_ipnn.py"
OPTS+=" -t holistic"
# OPTS+=" -e"
for DS in $(cat $SCRIPT_DIR/hbb-files.txt); do
    ${SCRIPT_DIR}/simple-grid-sub.sh $OPTS -d $DS
done


