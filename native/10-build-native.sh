#!/bin/bash
set -euo pipefail
GRPC_SRC=~/src/grpc
GCC_EXE=gcc

errx () { echo "ERROR: $*" 2>&1; exit 1; }

ver=$( cd $GRPC_SRC && git describe --tags )
[ -n "$ver" ] || errx "Unable to extract git version from $GRPC_SRC"
echo "INFO: Using gRPC sources $ver under $GRPC_SRC"

INSTALL_BASEDIR=/opt/grpc-$ver
echo "INFO: Target installation directory: $INSTALL_BASEDIR"

[ -d "$INSTALL_BASEDIR" ] || errx "Target install base dir $INSTALL_BASEDIR does not exist"

MACH=$( $GCC_EXE -dumpmachine )
echo "INFO: Using GCC compiler $GCC_EXE machine $MACH"
INSTALL_DIR=$INSTALL_BASEDIR/$MACH
echo "INFO: Target installation dir: $INSTALL_DIR"

set -x
rm -rf $INSTALL_DIR
mkdir -p $INSTALL_DIR
cd $GRPC_SRC
rm -rf cmake/build
mkdir -p cmake/build
pushd cmake/build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=17 \
	-DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF \
	-DCMAKE_INSTALL_PREFIX=$INSTALL_DIR \
	../..
make -j`nproc` install
popd
exit 0

