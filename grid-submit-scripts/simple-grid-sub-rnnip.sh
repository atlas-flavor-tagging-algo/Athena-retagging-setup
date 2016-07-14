#!/usr/bin/env bash
DS=mc15_13TeV:mc15_13TeV.410000.PowhegPythiaEvtGen_P2012_ttbar_hdamp172p5_nonallhad.merge.DAOD_FTAG2.e3698_s2608_s2183_r7725_r7676_p2625/

# check the voms
VOMS=$(voms-proxy-info --vo 2> /dev/null)
if [[ -z $VOMS ]] ; then
    echo "ERROR: no voms, quitting" >&2
    exit 1
elif [[ $VOMS == atlas ]] ; then
    SCOPE=user.${USER}
    OFFICIAL_OPTS=""
else
    SCOPE=group.$(echo $VOMS | cut -d / -f 3)
    OFFICIAL_OPTS=" --official --voms ${VOMS}/Role=production"
fi

# figure out new DS name
HEAD=$(echo $DS | cut -d : -f 2 | cut -d . -f 1-2)
PROC=$(echo $DS | cut -d . -f 3 | sed -r 's/([^_]*).*/\1/')
FLAV=$(echo $DS | cut -d . -f 5 | sed -r 's/.*AOD_(.*)/\1/')
TAGS=$(echo $DS | cut -d . -f 6 | sed -r 's:/::')
GITT=$(git describe)
OUT=${SCOPE}.${HEAD}.${PROC}_${FLAV}.${TAGS}.${GITT}

# setup options
OPTS=""
# OPTS+=" --nFilesPerJob 5"
# OPTS+=" --nFiles 2"
OPTS+=${OFFICIAL_OPTS}
OPTS+=" --nFiles 50"
# OPTS+=" --excludedSite=ANALY_FZK,ANALY_FZK_HI"
OPTS+=" --extFile ipmp.json,ipmk.json,dl1.json"
pathena jobOptions_ipmp.py --inDS $DS --outDS $OUT $OPTS
