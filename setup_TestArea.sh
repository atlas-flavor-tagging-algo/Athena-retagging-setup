#!/usr/bin/env bash

# ________________________________________________________________________
function _usage() {
    echo "usage $0 $1 <branch or trunk> [<test area directory>]"
}

function _help() {
    cat <<EOF
Script to make the frequent setup of your Athena test area less
uncomfortable.

To use it you'll need:
 - Make up you mind if you want to use the trunk or an older set of packages
   in a certain branch arrangement.
   This is to be specified by an additional argument when sourcing
   this script.

This script will:
 - Set up Athena in the (to be) specified directory. The path can
   be given as a second argument, otherwise you'll be asked to specify it.
EOF
}
# ________________________________________________________________________

# sanity check to make sure the Athena version fits
if [ "$1" != "branch" -a "$1" != "trunk" ]; then
    echo "ERROR: You did not decide on using either the branch or the trunk in your setup.\n"
    _usage
    _help
    exit 1
fi

# make aliases from your ~/.bashrc available
shopt -s expand_aliases

# set up ATLAS stuff
export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
alias setupATLAS='source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh'

if [[ ! $ATLAS_LOCAL_ASETUP_VERSION ]] ; then
    echo -n "setting up local ATLAS environment..."
    setupATLAS -q
    lsetup asetup
    echo "done"
else
    echo "ATLAS environment is already setup, not setting up again"
fi

# setup test area directory
if (( $# < 2 )) ; then
    echo "Please enter the directory name (from current directory) in which you want to set up the test area: "
    read TestArea_path
    echo "The test area will be set up in the directory: $PWD/$TestArea_path"
else
    TestArea_path=$2
    echo "The test area will be set up in the directory: $TestArea_path"
fi

# actually setting up Athena
cd $TestArea_path
if [[ "$1" == "branch" ]]; then
    asetup 20.1.6.3,AtlasDerivation,gcc48,here,64
elif [[ "$1" == "trunk" ]]; then
    asetup 20.7.3.3,AtlasDerivation,gcc48,here,64
fi
