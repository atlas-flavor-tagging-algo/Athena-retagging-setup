#!/usr/bin/env bash
#
# submit jobs for h->bb studies

set -eu


SCRIPT_DIR=$(dirname $BASH_SOURCE)
ZIP=holistic.tgz
OUT_DATASETS=$(mktemp)
OUT_DATASETS_FINAL=output-datasets.txt

function cleanup() {
    if [[ -f ${ZIP} ]] ; then
        echo "removing ${ZIP}"
        rm ${ZIP}
    fi
    echo "storing output ds names in ${OUT_DATASETS_FINAL}"
    mv -f $OUT_DATASETS $OUT_DATASETS_FINAL
}
trap cleanup EXIT

OPTS=" -j jobOptions_holistic.py"
OPTS+=" -t holistic"
# OPTS+=" -n 1"
# OPTS+=" -e"
OPTS+=" -z ${ZIP}"
for DS in $(cat $SCRIPT_DIR/hbb-files-resub.txt); do
    ${SCRIPT_DIR}/ftag-grid-sub.sh $OPTS -d $DS >> $OUT_DATASETS
done

