#!/usr/bin/env bash

# Script to figure out the voms and output file name to submit
# with. Removes unneeded crap from the input file name to get the
# output name and checks for `production` roll to find the submit
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
OUT=${SCOPE}.${HEAD}.${PROC}_${FLAV}.${TAGS}.${GITT}
if [[ -n $TAG ]] ; then
    OUT+=.${TAG}
fi

echo ${OUT}${OFFICIAL_OPTS}
