
# ________________________________________________________________________
function _usage() {
    echo "usage: $BASH_SOURCE <test area directory>"
}

function _help() {
    cat <<EOF
Script to make the frequent setup of your Athena test area less
uncomfortable.

This script will:
 - Set up Athena in the (to be) specified directory.

EOF
}
# ________________________________________________________________________

# checks
if (( $# < 1 )) ; then
    _usage
    _help
    return 1
fi

if [[ ! -d $1 ]] ; then
    echo "ERROR: $TEST_AREA_NAME doesn't exist" >&2
    return 1
fi

# remember this directory
pushd .
cd $1
echo "The test area will be set up in the directory: $1"

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
# actually setting up Athena
asetup 20.7.3.3,AtlasDerivation,gcc48,here,64

# go back to where we started
popd
