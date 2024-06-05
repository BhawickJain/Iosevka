#!/bin/bash
#
# Build fontcc docker image and then build private font build toml
# Built fonts are found in ./dist

set -euo pipefail
# -e: exit on error
# -u: treat unset variables as errors
# -o pipefail: exit if any command pipe has a failure


# build image for building font
# globals: none
# arguments: none
# returns: none
build_image() {
  echo -e $'\n\001\033[1;44m\033[1;30m\002 BUILD IMAGE: fontcc \001\033[0m\002'
  (         # enter subshell scope
    set -x  # show invoked commands in scope
    cd docker/
	docker build -t=fontcc .
  )
  echo -e $'\001\033[1;34m\002done. \001\033[0m\002'
}


# build font using docker image: fontcc
# globals: none
# arguments: none
# returns: none
build_font() {
  echo -e $'\n\001\033[1;44m\033[1;30m\002 BUILD FONT \001\033[0m\002'
  (         # enter subshell scope
    set -x  # show invoked commands in scope
	docker run -it --rm -v $PWD:/work fontcc contents::IosevkaCustom
	ls -lR dist/
  )
  echo -e $'\001\033[1;34m\002done. \001\033[0m\002'
}

build_image
build_font

