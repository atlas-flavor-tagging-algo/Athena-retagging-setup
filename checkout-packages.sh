#!/usr/bin/env bash

set -eu

# ________________________________________________________________________
# checkout packages (some are commented out because we may not need them)

cmt co -r MVAUtils-00-00-04 Reconstruction/MVAUtils
pkgco.py BTagging-00-07-64
pkgco.py JetTagTools-01-00-96-03
# pkgco.py JetTagTools-01-00-96

# git clone git@github.com:atlas-flavor-tagging-algo/xAODAthena.git
svn co svn+ssh://svn.cern.ch/reps/atlasperf/CombPerf/FlavorTag/FlavourTagPerformanceFramework/tags/FlavourTagPerformanceFramework-00-00-14/xAODAthena
setupWorkArea.py
