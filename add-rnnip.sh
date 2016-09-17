#!/usr/bin/env bash

if [[ $- == *i* ]] ; then
    echo "Don't source me bro!" >&2
    return 1
else
    set -eu
fi

cd run/

# download the configs
wget dguest.web.cern.ch/dguest/2016-09-12/ipmp.json
wget dguest.web.cern.ch/dguest/2016-09-12/ipz.json

JO_DIR=${TestArea}/xAODAthena/run
PATCH_DIR=${TestArea}/../job-option-patches

# link to ipmp jo
ln -sf $JO_DIR/jobOptions_ipmp.py

