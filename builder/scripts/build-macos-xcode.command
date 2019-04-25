#!/bin/bash

cd "`dirname "${0}"`"

ROOT_FOLDER=${PWD}/../..

if [[ ${BUILD_CONFIGURATION:+x} ]]; then
    BUILD_FOLDER=${ROOT_FOLDER}/build/macos-xcode-$(echo ${BUILD_CONFIGURATION} | tr '[:upper:]' '[:lower:]')
    BUILD_TYPE="--config ${BUILD_CONFIGURATION}"
else
    BUILD_FOLDER=${ROOT_FOLDER}/build/macos-xcode
    BUILD_TYPE=""
fi

mkdir -p ${BUILD_FOLDER}
cd ${BUILD_FOLDER}

cmake -G"Xcode" ${ROOT_FOLDER} ${BUILD_TYPE}
cmake --build ${BUILD_FOLDER}
