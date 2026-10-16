#!/bin/bash
set -xeuo pipefail
mkdir -p ~/src
cd ~/src
curl -fLO https://gitlab.arm.com/api/v4/projects/tooling%2Fgnu-toolchains-for-arm/packages/generic/gnu-toolchain/11.2-2022.02/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
sudo tar -xv --no-same-owner -f gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz  -C /opt
exit 0
