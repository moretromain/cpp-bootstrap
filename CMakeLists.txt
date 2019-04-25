cmake_minimum_required(VERSION 3.14.3 FATAL_ERROR)
cmake_policy(SET CMP0021 NEW)   # Fatal error on relative paths in INCLUDE_DIRECTORIES target property.

add_subdirectory(builder)

project(${BUILDER_ROOT_PROJECT_NAME} C CXX)

set_build_flags()

add_subdirectory(src)
