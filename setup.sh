# Script to build environment

ATHENA_DIR=athena
START_DIR=$(pwd)
cd $(dirname ${BASH_SOURCE})

# functions (expect to be executed within ATHENA_DIR)
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
    . ${START_DIR}/setup-athena.sh
    _build_packages
else
    cd $ATHENA_DIR
    . ${START_DIR}/setup-athena.sh
fi

cd $START_DIR

# cleanup
unset ATHENA_DIR START_DIR
unset -f _build_packages
