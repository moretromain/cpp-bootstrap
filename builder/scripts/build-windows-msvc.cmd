setlocal enableextensions

cd /d %~dp0

set ROOT_FOLDER=%cd%\..\..
set BUILD_FOLDER=%ROOT_FOLDER%\build\windows-msvc15

mkdir %BUILD_FOLDER%
cd %BUILD_FOLDER%

cmake -G "Visual Studio 15 2017" -A x64 %ROOT_FOLDER%
cmake --build %BUILD_FOLDER% --config %BUILD_CONFIGURATION%
