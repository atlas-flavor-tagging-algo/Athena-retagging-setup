
# ________________________________________________________________________
function _usage() {
    echo "usage: $BASH_SOURCE <testarea directory>"
}

function _help() {
    cat <<EOF
Script to make the creation of a Athena test area less painful.

To use it you'll need:
 - Make up your mind if you want to use the trunk or an older branch.
   This is to be specified by an additional argument when sourcing
   this script.

This script will:
 - Set up the required environment variables.
 - Set up Athena in the (to be) specified directory.
EOF
}

# _______________________________________________________________________
# main routine starts here

if (( $# < 1 )) ; then
    _usage
    _help
    return 1
fi

TEST_AREA_NAME=$1

# setup test area, move into it
if [[ ! -d $TEST_AREA_NAME ]] ; then
    mkdir $TEST_AREA_NAME
else
    echo "$TEST_AREA_NAME already exists, quitting..." >&2
    return 1
fi
. setup-environment.sh $TEST_AREA_NAME

SRC_DIR=$(pwd)  # come back to this directory later
cd $TEST_AREA_NAME

# run other setup subjobs
${SRC_DIR}/checkout-packages.sh
${SRC_DIR}/build-packages.sh
${SRC_DIR}/copy-job-options.sh
# several things to setup rnnip
${SRC_DIR}/add-rnnip.sh
${SRC_DIR}/add-dl1.sh

# go back to the directory we started in
cd $SRC_DIR

# cleanup
unset SRC_DIR TEST_AREA_NAME
unset -f _usage _help _files_exist
