#!/usr/bin/env bash

set -eu

# defaults
JO=jobOptions_ipmp.py
DS=mc15_13TeV:mc15_13TeV.410000.PowhegPythiaEvtGen_P2012_ttbar_hdamp172p5_nonallhad.merge.DAOD_FTAG2.e3698_s2608_s2183_r7725_r7676_p2625/

_usage() {
    echo "usage: ${0##*/} [-h]"
}
_help() {
    _usage
    cat <<EOF

Submit job over some dataset.

Options:
 -h: get help
 -n: n files to use (default all)
 -j: jobOptions to use (default ${JO})
 -d: input dataset to use (default ${DS})
 -t: tag for output dataset
 -e: test run, just echo command

EOF
}

OPTS=""
PREFIX_CMD=""
TAG=""
while getopts ":hn:j:d:et:" opt $@; do
	  case $opt in
	      h) _help; exit 1;;
	      n) OPTS+=" --nFiles ${OPTARG}";;
        j) JO=${OPTARG};;
        d) DS=${OPTARG};;
        t) TAG=${OPTARG};;
        e) PREFIX_CMD=echo;;
	      # handle errors
	      \?) _usage; echo "Unknown option: -$OPTARG" >&2; exit 1;;
        :) _usage; echo "Missing argument for -$OPTARG" >&2; exit 1;;
        *) _usage; echo "Unimplemented option: -$OPTARG" >&2; exit 1;;
	  esac
done

SCRIPT_DIR=$(dirname $BASH_SOURCE)
OUT_OPTS=$(${SCRIPT_DIR}/output-from-input-and-voms.sh $DS $TAG)

# setup options
# OPTS+=" --nFilesPerJob 5"
# OPTS+=" --nFiles 2"
OPTS+=${OUT_OPTS}
# OPTS+=" --nFiles 50"
# OPTS+=" --excludedSite=ANALY_FZK,ANALY_FZK_HI"
OPTS+=" --extFile ipmp.json,ipmk.json,dl1.json"
${PREFIX_CMD} pathena ${JO} --inDS $DS $OUT_OPTS $OPTS
