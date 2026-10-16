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
INSTALL_HOSTDIR=$INSTALL_BASEDIR/host-$MACH
echo "INFO: Target installation dir: $INSTALL_HOSTDIR"

set -x
rm -rf $INSTALL_HOSTDIR
mkdir -p $INSTALL_HOSTDIR
cd $GRPC_SRC
rm -rf cmake/build-host
mkdir -p cmake/build-host
pushd cmake/build-host
# Note Fedora 45 has incompatible openssl-devel package, thus
# commented out: -DgRPC_SSL_PROVIDER=package
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=17 \
  -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF \
  -DgRPC_BUILD_GRPC_NODE_PLUGIN=OFF \
  -DgRPC_BUILD_GRPC_OBJECTIVE_C_PLUGIN=OFF -DgRPC_BUILD_GRPC_PHP_PLUGIN=OFF \
  -DgRPC_BUILD_GRPC_RUBY_PLUGIN=OFF -DgRPC_BUILD_GRPCPP_OTEL_PLUGIN=OFF \
  -DgRPC_DOWNLOAD_ARCHIVES=OFF \
  -DCMAKE_INSTALL_PREFIX=$INSTALL_HOSTDIR \
  ../..
make -j`nproc` install
popd
exit 0

