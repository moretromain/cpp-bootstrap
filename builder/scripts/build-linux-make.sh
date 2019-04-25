#!/bin/bash

cd "`dirname "${0}"`"

ROOT_FOLDER=${PWD}/../..
BUILD_FOLDER=${ROOT_FOLDER}/build/linux-make-${BUILD_CONFIGURATION,,}

mkdir -p ${BUILD_FOLDER}
cd ${BUILD_FOLDER}

cmake -G"Unix Makefiles" ${ROOT_FOLDER} -DCMAKE_BUILD_TYPE=${BUILD_CONFIGURATION}
cmake --build ${BUILD_FOLDER}
