#!/usr/bin/env bash
DS=mc15_13TeV:mc15_13TeV.410000.PowhegPythiaEvtGen_P2012_ttbar_hdamp172p5_nonallhad.recon.AOD.e3698_s2608_s2183_r7377_r7351/
OUT=user.dguest.410000.rnnip_slim.v1
# rucio list-dids $DS
# OPTS="--nFilesPerJob 5"
# OPTS=" --nFiles 5 --express"
# OPTS=" --nFiles 1"
OPTS+=" --excludedSite=ANALY_FZK"
OPTS+=" --extFile ipmp.json"
pathena jobOptions_tagdl1.py --inDS $DS --outDS $OUT $OPTS
