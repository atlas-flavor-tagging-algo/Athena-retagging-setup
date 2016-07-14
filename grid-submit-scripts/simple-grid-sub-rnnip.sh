#!/usr/bin/env bash


SCRIPT_DIR=$(dirname $BASH_SOURCE)

${SCRIPT_DIR}/simple-grid-sub.sh\
             -j jobOptions_ipnn.py\
             -d mc15_13TeV:mc15_13TeV.410000.PowhegPythiaEvtGen_P2012_ttbar_hdamp172p5_nonallhad.merge.DAOD_FTAG2.e3698_s2608_s2183_r7725_r7676_p2625/\
             -t ipnn\
             -e


