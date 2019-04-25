cmake_minimum_required(VERSION 3.14.3 FATAL_ERROR)
add_subdirectory(builder)
project(cppbootstrap C CXX)
set_build_flags()

add_subdirectory(src)
