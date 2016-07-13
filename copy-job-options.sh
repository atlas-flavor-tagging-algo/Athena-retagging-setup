#!/usr/bin/env bash

set -eu

if [[ ! -d $TestArea/xAODAthena/run ]] ; then
    echo "ERROR: no run directory found to copy files from..." >&2
    exit 1
fi

# setup run area
mkdir -p run
# copy files out of the xAODFramework
for FILE in RetagFragment.py ; do
    cp $TestArea/xAODAthena/run/$FILE run/
done

# link the job options files from this package
JO_DIR=$TestArea/xAODAthena/run
cd run/
ln -sf $JO_DIR/jobOptions_tagdl1.py
ln -sf $JO_DIR/jobOptions_Tag_bb.py jobOptions_tagbb.py
ln -sf $JO_DIR/jobOptions_Tag.py jobOptions_tag.py
PATCH_DIR=${TestArea}/../job-option-patches
patch jobOptions_tag.py < ${PATCH_DIR}/single-b-jo-hack.patch
