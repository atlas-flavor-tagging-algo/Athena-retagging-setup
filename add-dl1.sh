#!/usr/bin/env bash

set -eu

BASE_NN_DIR=/afs/cern.ch/work/m/malanfer/public/training
LOCAL_DL1_CONFIG=${BASE_NN_DIR}/BTagging_DL1_NNconfig.json
if [[ ! -f $(readlink -m $LOCAL_DL1_CONFIG) ]] ; then
    echo "ERROR: local DL1 config not found" >&2
else
    cp $LOCAL_DL1_CONFIG $TestArea/run/.
fi
