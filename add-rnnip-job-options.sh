#!/usr/bin/env bash

set -eu

cd run/

# download the IPMP config
wget http://dguest.web.cern.ch/dguest/nn-tests/ipmp.json.gz
gunzip ipmp.json.gz
# and IPMK
wget http://dguest.web.cern.ch/dguest/nn-tests/ipmk.json.gz
gunzip ipmk.json.gz

JO_DIR=${TestArea}/xAODAthena/run
PATCH_DIR=${TestArea}/../job-option-patches

# patch the dl1 config
patch -p0 < $PATCH_DIR/dl1-to-ipmp.patch
mv jobOptions_tagdl1.py jobOptions_ipmp.py
# and relink
ln -sf $JO_DIR/jobOptions_tagdl1.py

