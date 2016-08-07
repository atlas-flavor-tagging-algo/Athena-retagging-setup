# Script to build environment

ATHENA_DIR=athena
START_DIR=$(pwd)
echo ${BASH_SOURCE}
cd $(dirname ${BASH_SOURCE})

# functions (expect to be executed within ATHENA_DIR)
function _setup_athena() {
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
    asetup 20.7.6.1,AtlasDerivation,here
}
function _build_packages() {
    # run other setup subjobs
    local SRC_DIR=..
    ${SRC_DIR}/checkout-packages.sh
    ${SRC_DIR}/build-packages.sh
    ${SRC_DIR}/copy-job-options.sh
    # several things to setup rnnip
    ${SRC_DIR}/add-rnnip.sh
    ${SRC_DIR}/add-dl1.sh
}

# ------- main stuff here ----------
if [[ ! -d $ATHENA_DIR ]] ; then
    mkdir $ATHENA_DIR
    cd $ATHENA_DIR
    _setup_athena
    _build_packages
else
    cd $ATHENA_DIR
    _setup_athena
fi

cd $START_DIR

# cleanup
unset ATHENA_DIR START_DIR
unset -f _setup_athena _build_packages
