# Scripts to (cross)build gRPC from source

Set of scripts to build gRPC.

Tested Host OS (always `x86_64` also known as `amd64`):
* Debian 13
* Fedora 45 Server Edition Prerelease (Oct 16, 2026)
* openSUSE LEAP 16.1 RC (Oct 16, 2026)
* Ubuntu 22.04.5 LTS

To clone source of this project you need to install `git(1)` first, typically with:
```shell
sudo apt-get install git-core # Debian/Ubuntu
sudo dnf     install git-core # Fedora
sudo zypper  in      git-core # openSUSE LEAP
```

And retrieve this source:

```shell
mkdir -p ~/projects
cd ~/projects
git clone https://github.com/hpaluch-pil/grpc-build-scripts.git
cd grpc-build-scripts
```

Setup - common for all builds:
```shell
# on Debian and/or Ubuntu:
common/01-install-apt.sh
# on Fedora:
common/01-install-dnf.sh
# on openSUSE LEAP:
common/01-install-zypper.sh

# continued - common:
# line below will checkout gRPC sources into ~/src/grpc
common/02-clone-source.sh
# warning: it purges existing gRPC installation in /opt/grpc-VERSION!
common/03-prepare-install-basedir.sh
```

Note: build artifacts are installed under `/opt/grpc-VERSION/ARCH`.

Continued - variant 1 - native build (Host = Target):
```shell
native/10-build-native.sh
native/30-example-native.sh
```

Continued - variant 2 - cross-build for ARM64 GCC11 Target on `amd64` Host:
```shell
cross-aarch64/05-install-gcc11-aarch64.sh
cross-aarch64/10-build-host.sh
cross-aarch64/20-build-aarch64.sh
cross-aarch64/30-example-aarch64.sh
```

# Resources

* https://grpc.io/docs/languages/cpp/quickstart/
* https://github.com/grpc/grpc/blob/master/BUILDING.md#cross-compiling
* https://github.com/grpc/grpc/blob/master/test/distrib/cpp/run_distrib_test_cmake_aarch64_cross.sh
