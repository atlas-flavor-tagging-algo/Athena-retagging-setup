#!/usr/bin/env bash
DS=mc15_13TeV:mc15_13TeV.410000.PowhegPythiaEvtGen_P2012_ttbar_hdamp172p5_nonallhad.merge.DAOD_FTAG2.e3698_s2608_s2183_r7725_r7676_p2625/

# figure out new DS name
HEAD=$(echo $DS | cut -d : -f 2 | cut -d . -f 1-2)
PROC=$(echo $DS | cut -d . -f 3 | sed -r 's/([^_]*).*/\1/')
FLAV=$(echo $DS | cut -d . -f 5 | sed -r 's/.*AOD_(.*)/\1/')
TAGS=$(echo $DS | cut -d . -f 6 | sed -r 's:/::')
GITT=$(git describe)
OUT=group.perf-flavtag.${HEAD}.${PROC}_${FLAV}.${TAGS}.${GITT}

# setup options
OPTS=""
# OPTS+=" --nFilesPerJob 5"
# OPTS+=" --nFiles 2"
OPTS=" --official --voms atlas:/atlas/perf-flavtag/Role=production"
OPTS+=" --nFiles 5"
# OPTS+=" --excludedSite=ANALY_FZK,ANALY_FZK_HI"
OPTS+=" --extFile ipmp.json,ipmk.json,dl1.json"
pathena jobOptions_ipmp.py --inDS $DS --outDS $OUT $OPTS
