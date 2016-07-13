#!/usr/bin/env bash

set -eu

# ________________________________________________________________________
# build all the things
cd WorkArea/cmt
cmt bro cmt config
cmt bro cmt make
