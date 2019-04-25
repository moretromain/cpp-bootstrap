setlocal enableextensions

set ROOT_FOLDER=%cd%
set BUILD_FOLDER=%ROOT_FOLDER%\build
set CMAKE_BINARY=cmake-gui.exe

mkdir %BUILD_FOLDER%
cd %BUILD_FOLDER%

%CMAKE_BINARY% %ROOT_FOLDER%

cd %ROOT_FOLDER%
