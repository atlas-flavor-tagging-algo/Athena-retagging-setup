#!/usr/bin/env bash

set -eu

cd run/

# download the IPMP config
wget http://dguest.web.cern.ch/dguest/nn-tunings/ipmp.json.gz
gunzip ipmp.json.gz
# and IPMK
wget http://dguest.web.cern.ch/dguest/nn-tests/ipmk.json.gz
gunzip ipmk.json.gz

JO_DIR=${TestArea}/xAODAthena/run
# link
ln -sf $JO_DIR/jobOptions_ipmp.py

