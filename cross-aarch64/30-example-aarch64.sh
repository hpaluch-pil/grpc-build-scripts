#!/bin/bash
set -euo pipefail
GRPC_SRC=~/src/grpc
GCC_EXE=/opt/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-gcc
GCC_EXE_HOST=gcc

errx () { echo "ERROR: $*" 2>&1; exit 1; }
MY_DIR=$( readlink -f $( dirname $0 ) )
# toolchain file
TC_FILE=$MY_DIR/toolchain_aarch64_gcc11.cmake
echo "INFO: Using CMake toolchain file '$TC_FILE'"
[ -f "$TC_FILE" ] || errx "Invalid toolchain pathname '$TC_FILE'"

ver=$( cd $GRPC_SRC && git describe --tags )
[ -n "$ver" ] || errx "Unable to extract git version from $GRPC_SRC"
echo "INFO: Using gRPC sources $ver under $GRPC_SRC"

INSTALL_BASEDIR=/opt/grpc-$ver
echo "INFO: Target install base directory: $INSTALL_BASEDIR"

[ -d "$INSTALL_BASEDIR" ] || errx "Target install base dir $INSTALL_BASEDIR does not exist"
MACH_HOST=$( $GCC_EXE_HOST -dumpmachine )
INSTALL_HOSTDIR=$INSTALL_BASEDIR/host-$MACH_HOST
[ -d "$INSTALL_HOSTDIR" ] || errx "Build Host install dir $INSTALL_HOSTDIR does not exist"
echo "INFO: Host build installation dir: $INSTALL_HOSTDIR"

MACH=$( $GCC_EXE -dumpmachine )
echo "INFO: Using cross GCC compiler $GCC_EXE machine $MACH"
INSTALL_TARGET=$INSTALL_BASEDIR/$MACH
echo "INFO: Target installation dir: $INSTALL_TARGET"

set -x
cd $GRPC_SRC
rm -rf "examples/cpp/helloworld/cmake/build-$MACH"
mkdir -p "examples/cpp/helloworld/cmake/build-$MACH"
pushd "examples/cpp/helloworld/cmake/build-$MACH"
PATH=$INSTALL_HOSTDIR/bin:$PATH
export PATH
cmake -DCMAKE_TOOLCHAIN_FILE=$TC_FILE \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_CXX_STANDARD=17 \
      -Dabsl_DIR=$INSTALL_TARGET/lib/cmake/absl \
      -DProtobuf_DIR=$INSTALL_TARGET/lib/cmake/protobuf \
      -Dutf8_range_DIR=$INSTALL_TARGET/lib/cmake/utf8_range \
      -DgRPC_DIR=$INSTALL_TARGET/lib/cmake/grpc \
      ../..
make -j`nproc`
set +x
echo "Example binaries build in: `pwd`"
set -x
popd
exit 0

