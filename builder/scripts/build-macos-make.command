#!/bin/bash

cd "`dirname "${0}"`"

ROOT_FOLDER=${PWD}/../..

if [[ ${BUILD_CONFIGURATION:+x} ]]; then
    BUILD_FOLDER=${ROOT_FOLDER}/build/macos-make-$(echo ${BUILD_CONFIGURATION} | tr '[:upper:]' '[:lower:]')
    BUILD_TYPE="-DCMAKE_BUILD_TYPE=${BUILD_CONFIGURATION}"
else
    BUILD_FOLDER=${ROOT_FOLDER}/build/macos-make
    BUILD_TYPE=""
fi

mkdir -p ${BUILD_FOLDER}
cd ${BUILD_FOLDER}

cmake -G"Unix Makefiles" ${ROOT_FOLDER} ${BUILD_TYPE}
cmake --build ${BUILD_FOLDER}
