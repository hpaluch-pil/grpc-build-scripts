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
cd /d "%~1\build\%APP%-%CONFIGURATION%" || goto err
"%CM%" --build . --config %CONFIGURATION% --target install  -j %NUMBER_OF_PROCESSORS% || goto err
@echo OK: Build finished
exit /b 0

:usage
echo Usage: %0 BUILD_WORKSPACE
echo For example, run: %0 c:\TEMP
exit /b 1

:err
exit /b %ERRORLEVEL%

