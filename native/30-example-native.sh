#!/bin/bash
set -euo pipefail
GRPC_SRC=~/src/grpc
GCC_EXE=gcc

errx () { echo "ERROR: $*" 2>&1; exit 1; }

ver=$( cd $GRPC_SRC && git describe --tags )
[ -n "$ver" ] || errx "Unable to extract git version from $GRPC_SRC"
echo "INFO: Using gRPC sources $ver under $GRPC_SRC"

INSTALL_BASEDIR=/opt/grpc-$ver
echo "INFO: Target install base directory: $INSTALL_BASEDIR"
[ -d "$INSTALL_BASEDIR" ] || errx "Target install base dir $INSTALL_BASEDIR does not exist"

MACH=$( $GCC_EXE -dumpmachine )
echo "INFO: Using GCC compiler $GCC_EXE machine $MACH"
INSTALL_DIR=$INSTALL_BASEDIR/$MACH
echo "INFO: Target installation dir: $INSTALL_DIR"

set -x
cd $GRPC_SRC
rm -rf "examples/cpp/helloworld/cmake/build"
mkdir -p "examples/cpp/helloworld/cmake/build"
pushd "examples/cpp/helloworld/cmake/build"
PATH=$INSTALL_DIR/bin:$PATH
export PATH
cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_CXX_STANDARD=17 \
      -Dabsl_DIR=$INSTALL_DIR/lib/cmake/absl \
      -DProtobuf_DIR=$INSTALL_DIR/lib/cmake/protobuf \
      -Dutf8_range_DIR=$INSTALL_DIR/lib/cmake/utf8_range \
      -DgRPC_DIR=$INSTALL_DIR/lib/cmake/grpc \
      ../..
make -j`nproc`
set +x
echo "Example binaries build in: `pwd`"
set -x
popd
exit 0

