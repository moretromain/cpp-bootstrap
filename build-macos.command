#!/bin/bash

cd "`dirname "${0}"`"

ROOT_FOLDER="${PWD}"
BUILD_FOLDER="${ROOT_FOLDER}/build"
CMAKE_BINARY=cmake-gui

mkdir -p ${BUILD_FOLDER}
cd ${BUILD_FOLDER}

${CMAKE_BINARY} ${ROOT_FOLDER}

cd ${ROOT_FOLDER}
