:: windows build of gRPC using cmake(1)
:: WARNING! Hardcoded for VS2019  on C:
@echo off
setlocal
REM WARNING! Debug is broken!
set CONFIGURATION=Release
set MY_INSTALL_DIR=c:\libs\grpc-v1.82.0\%CONFIGURATION%
set CM=c:\Program Files\CMake\bin\cmake.exe
set APP=grpc
set MY_PWD0=%~sdp0
set MY_PWD=%MY_PWD0:~0,-1%

if "%~1" == "" (
  echo Must specify 1st argument - Workspace DIRECTORY for build
  goto usage
)
if not exist "%~1" (
  echo Specified directory '%1' does not exist
  exit /b 1
)

@echo on
rmdir /s /q "%~1\build\%APP%-%CONFIGURATION%"
md "%~1\build\%APP%-%CONFIGURATION%" || goto err
cd /d "%~1\build\%APP%-%CONFIGURATION%" || goto err
"%CM%" ^
   -G "Visual Studio 16 2019" ^
   -DCMAKE_BUILD_TYPE=%CONFIGURATION% ^
   -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF -DBUILD_SHARED_LIBS=OFF ^
   -DCMAKE_CXX_STANDARD=17 -DCMAKE_INSTALL_PREFIX=%MY_INSTALL_DIR% ^
   "%MY_PWD%\grpc" || goto err
@echo OK: Now run: 10-build-grpc-solution.cmd %1
exit /b 0

:usage
echo Usage: %0 BUILD_WORKSPACE
echo For example, run: %0 c:\TEMP
exit /b 1

:err
exit /b %ERRORLEVEL%

