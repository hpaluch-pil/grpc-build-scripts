# Building gRPC on Windows

Note: to build on Linux, see parent [../README.md](../README.md)

Requirements:
* install Git for Windows 2.53 or older,
  from: https://github.com/git-for-windows/git/releases/download/v2.53.0.windows.3/Git-2.53.0.3-64-bit.exe

  > WARNING! Avoid Git 2.54 or 2.55 - there are known issues when checking out big gRPC source tree:
  > * https://github.com/git-for-windows/git/issues/6210
  > * https://github.com/ScoopInstaller/Scoop/issues/6665

* install latest CMake 3.x from: https://github.com/Kitware/CMake/releases/download/v3.31.12/cmake-3.31.12-windows-x86_64.msi

  > WARNING! Do not use CMake 4.x (or later) - it is incompatible with existing gRPC source

* install Visual Studio 2019, with `C++ Desktop` Workload. Tested Professional edition (requires
  subscription)

Now run this command in Git BASH terminal - it will checkout gRPC sources into `C:\SRC` (currently hardcoded):

```shell
./01-clone-grpc.sh
```

Now do this in CMD.exe to build and install gRPC into: `c:\libs\grpc-v1.82.0\Release`:

```cmd
copy *.cmd c:\src
cd /d c:\src
05-generate-grpc-solution.cmd c:\TEMP
10-build-grpc-solution.cmd c:\TEMP
```

> WARNING! Current gRPC is broken when building in Debug mode, see (unresolved) details
> on: https://github.com/grpc/grpc/issues/23326

When done, you can visit Hello World example project on: https://github.com/hpaluch-pil/grpc-hello-cpp to
try to use this installed gRPC library.

# Resources

* https://grpc.io/docs/languages/cpp/quickstart/
* https://github.com/git-for-windows/git/issues/6210
* https://github.com/grpc/grpc/issues/23326

