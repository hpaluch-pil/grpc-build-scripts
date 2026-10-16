#!/bin/bash
# install required packages via Zypper
set -xeuo pipefail
sudo zypper in -t pattern devel_C_C++
# F45 has incompatible openssl-devel - omitted
sudo zypper in git-core cmake tar curl
exit 0
