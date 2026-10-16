#!/bin/bash
set -euo pipefail

GRPC_SRC=~/src/grpc

errx () { echo "ERROR: $*" 2>&1; exit 1; }
ver=$( cd $GRPC_SRC && git describe --tags )
[ -n "$ver" ] || errx "Unable to extract git version from $GRPC_SRC"
echo "INFO: Using gRPC sources $ver under $GRPC_SRC"

INSTALL_BASEDIR=/opt/grpc-$ver
echo "Target installation directory: $INSTALL_BASEDIR"

if [ -d "$INSTALL_BASEDIR" ]; then
	# delete all files under installation dir, but keep directory
	# to avoid need running sudo again
	set -x
	find $INSTALL_BASEDIR -mindepth 1 -delete
	set +x
else
	set -x
	sudo mkdir -p $INSTALL_BASEDIR
	sudo chown `id -un`:`id -gn` $INSTALL_BASEDIR
	set +x
fi
echo "(Re)created Target installation directory: $INSTALL_BASEDIR"
exit 0

