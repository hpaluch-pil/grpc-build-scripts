#!/bin/bash
set -xeuo pipefail
# from: https://grpc.io/docs/languages/cpp/quickstart/
mkdir -p /c/src
cd /c/src
git clone --recurse-submodules -b v1.82.0 --depth 1 --shallow-submodules https://github.com/grpc/grpc
exit 0
