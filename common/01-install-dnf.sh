#!/bin/bash
# install required packages via DNF
set -xeuo pipefail
sudo dnf group install c-development
# F45 has incompatible openssl-devel - omitted
sudo dnf install git-core cmake tar curl
exit 0
