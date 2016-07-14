#!/usr/bin/env bash

# Script to figure out the voms and output file nameing options to
# submit with. Removes unneeded crap from the input file name to get
# the output name and checks for `production` roll to find the submit
# rights.

set -eu

DS=$1
TAG=${2-}

# check the voms
VOMS=$(voms-proxy-info --vo 2> /dev/null)
if [[ -z $VOMS ]] ; then
    echo "ERROR: no voms, quitting" >&2
    exit 1
elif [[ $VOMS == atlas ]] ; then
    SCOPE=user.${USER}
    OFFICIAL_OPTS=""
    FQAN=$(voms-proxy-info --fqan 2> /dev/null | grep 'Role=production' )
    # if we have production rights add that to the scope / queue
    if [[ -n $FQAN ]] ; then
        SCOPE=group.$(echo $FQAN | cut -d / -f 3)
        OFFICIAL_OPTS=" --official --voms ${VOMS}:${FQAN%/*}"
    fi
fi

# figure out new DS name
HEAD=$(echo $DS | cut -d : -f 2 | cut -d . -f 1-2)
PROC=$(echo $DS | cut -d . -f 3 | sed -r 's/([^_]*).*/\1/')
FLAV=$(echo $DS | cut -d . -f 5 | sed -r 's/.*AOD_(.*)/\1/')
TAGS=$(echo $DS | cut -d . -f 6 | sed -r 's:/::')
GITT=$(git describe)
APP=""
if [[ -n $TAG ]] ; then
    APP=.${TAG}
fi
OUT=${SCOPE}.${HEAD}.${PROC}_${FLAV}.${TAGS}.${GITT}${APP}

# possibly cut down the size further
if (( $(echo $OUT | wc -c) > 115 )) ; then
    OUT=${SCOPE}.${HEAD}.${FLAV}.${TAGS}.${GITT}${APP}
fi
if (( $(echo $OUT | wc -c) > 115 )) ; then
    echo "ERROR: ds name $OUT is too long" >&2
    exit 1
fi

echo --outDS ${OUT}${OFFICIAL_OPTS}
