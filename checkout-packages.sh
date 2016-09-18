#!/usr/bin/env bash

if [[ $- == *i* ]] ; then
    echo "Don't source me bro!" >&2
    return 1
else
    set -eu
fi

# ________________________________________________________________________
# checkout packages (some are commented out because we may not need them)

cmt co -r MVAUtils-00-00-04 Reconstruction/MVAUtils
pkgco.py BTagging-00-07-64
pkgco.py JetTagTools-01-00-96-03
# pkgco.py JetTagTools-01-00-96

# git clone git@github.com:atlas-flavor-tagging-algo/xAODAthena.git
ATL_PERF=svn+ssh://svn.cern.ch/reps/atlasperf
PACKAGE=CombPerf/FlavorTag/FlavourTagPerformanceFramework
PERF_TAG=FlavourTagPerformanceFramework-00-00-14-00
svn co ${ATL_PERF}/${PACKAGE}/tags/${PERF_TAG}/xAODAthena
setupWorkArea.py
