#!/usr/bin/env bash
#
# submit jobs for h->bb studies

set -eu
if (( $# < 1 )); then
    echo "usage: ${0##*/} <input_dataest_list>" >&2
    exit 1
fi
INPUT_FILE=$1

SCRIPT_DIR=$(dirname $BASH_SOURCE)
ZIP=holistic.tgz
OUT_DATASETS=$(mktemp)
OUT_DATASETS_FINAL=output-datasets-$(date +%F-%k-%M).txt

function cleanup() {
    if [[ -f ${ZIP} ]] ; then
        echo "removing ${ZIP}"
        rm ${ZIP}
    fi
    if [[ $(wc $OUT_DATASETS -l | awk '{print $1}') != 0 ]] ; then
        echo "storing output ds names in ${OUT_DATASETS_FINAL}"
        mv -f $OUT_DATASETS $OUT_DATASETS_FINAL
    fi
}
trap cleanup EXIT

OPTS=" -j jobOptions_holistic.py"
OPTS+=" -t holistic"
# OPTS+=" -n 1"
# OPTS+=" -e"
OPTS+=" -z ${ZIP}"
for DS in $(cat $INPUT_FILE); do
    ${SCRIPT_DIR}/ftag-grid-sub.sh $OPTS -d $DS >> $OUT_DATASETS
done

