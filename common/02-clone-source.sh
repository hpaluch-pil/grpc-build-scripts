#!/bin/bash
# Clone gRPC source from GitHub
set -xeuo pipefail
mkdir -p ~/src
cd ~/src
rm -rf grpc
git clone --recurse-submodules -b v1.82.0 --depth 1 --shallow-submodules https://github.com/grpc/grpc
exit 0
