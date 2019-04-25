#!/bin/bash

cd "`dirname "${0}"`"

ROOT_FOLDER=${PWD}/../..
BUILD_FOLDER=${ROOT_FOLDER}/build/macos-xcode

mkdir -p ${BUILD_FOLDER}
cd ${BUILD_FOLDER}

cmake -G"Xcode" ${ROOT_FOLDER}
cmake --build ${BUILD_FOLDER} --config ${BUILD_CONFIGURATION}
