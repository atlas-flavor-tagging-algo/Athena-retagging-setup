
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
# function to make sure the test area is empty
_files_exist () {
    files=$(cd $1; shopt -s nullglob dotglob; echo *)
    if (( ${#files} )) ; then
        return 0
    else
        return 1
    fi
}

# _______________________________________________________________________
# main routine starts here

if (( $# < 1 )) ; then
    _usage
    _help
    return 1
fi

TEST_AREA_NAME=$1
# build test area, make sure it's empty
mkdir -p $TEST_AREA_NAME
if _files_exist $TEST_AREA_NAME; then
    echo "files exist in $TEST_AREA_NAME, quitting..."
    cd $SRC_DIR
    return 1
fi

# setup test area, move into it
. setup_TestArea.sh $TEST_AREA_NAME

SRC_DIR=$(pwd)  # come back to this directory later
cd $TEST_AREA_NAME

# ________________________________________________________________________
# checkout packages (some are commented out because we may not need them)

# pkgco.py BTagging-00-07-58
# pkgco.py JetTagTools-01-00-83
pkgco.py -A BTagging
pkgco.py -A JetTagTools
# pkgco.py JetMomentTools-00-03-20 # Athena is JetMomentTools-00-03-11-06
# pkgco.py PileupReweighting-00-03-06 # Athena is PileupReweighting-00-03-14

# TODO: should we just clone this to github?
svn co svn+ssh://svn.cern.ch/reps/atlasperf/CombPerf/FlavorTag/FlavourTagPerformanceFramework/trunk/xAODAthena xAODAthena
setupWorkArea.py

# ________________________________________________________________________
# build all the things
(
    cd WorkArea/cmt
    cmt bro cmt config
    cmt bro cmt make
)

# setup run area (do this in a subshell to avoid dumping local variables)
(
    mkdir -p run
    for FILE in jobOptions_Tag.py RetagFragment.py ; do
        cp $TestArea/xAODAthena/run/$FILE run/
    done

    # get default NN configuration file
    BASE_NN_DIR=/afs/cern.ch/work/m/malanfer/public/training
    LOCAL_DL1_CONFIG=${BASE_NN_DIR}/BTagging_DL1_NNconfig.json
    if [[ ! -f $(readlink -m $LOCAL_DL1_CONFIG) ]] ; then
        echo "ERROR: local DL1 config not found" >&2
    else
        cp $LOCAL_DL1_CONFIG $TestArea/run/.
    fi
    # link the job options file
    cd run/
    ln -sf $SRC_DIR/jobOptions_Tag_trunk.py
)

# go back to the directory we started in
cd $SRC_DIR

# cleanup
unset SRC_DIR TEST_AREA_NAME
unset -f _usage _help _files_exist
