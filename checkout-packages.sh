#!/usr/bin/env bash

# ________________________________________________________________________
# checkout packages (some are commented out because we may not need them)

cmt co -r MVAUtils-00-00-04 Reconstruction/MVAUtils
pkgco.py BTagging-00-07-62
pkgco.py JetTagTools-01-00-91

# git clone git@github.com:atlas-flavor-tagging-algo/xAODAthena.git
svn co svn+ssh://svn.cern.ch/reps/atlasperf/CombPerf/FlavorTag/FlavourTagPerformanceFramework/tags/FlavourTagPerformanceFramework-00-00-10/xAODAthena
setupWorkArea.py
