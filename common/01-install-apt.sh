#!/bin/bash
# install required packages via APT
set -xeuo pipefail
# Note: as Fedora 45 has incompatible openssl, we don't use it globally: omitted libssl-dev
sudo apt-get install git-core build-essential autoconf libtool pkg-config cmake tar curl
exit 0
