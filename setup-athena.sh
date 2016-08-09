# short script to setup athena locally
export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
alias setupATLAS='source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh'
if [[ ! $ATLAS_LOCAL_ASETUP_VERSION ]] ; then
    echo -n "setting up local ATLAS environment..."
    setupATLAS -q
    echo "done"
else
    echo "ATLAS environment is already setup, not setting up again"
fi
asetup 20.7.6.1,AtlasDerivation,here
