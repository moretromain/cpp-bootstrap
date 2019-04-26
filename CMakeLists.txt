cmake_minimum_required(VERSION 3.11 FATAL_ERROR)
cmake_policy(SET CMP0021 NEW) # Fatal error on relative paths in INCLUDE_DIRECTORIES target property.

add_subdirectory(builder)

project(${BUILDER_ROOT_PROJECT_NAME} C CXX)

builder_configure_platform()

if(LINUX_BUILD)
    builder_import_qt_modules(
        Concurrent
        Core
        Concurrent
        DataVisualization
        Qml
        Quick
        QuickControls2
        Multimedia
        Widgets
        OpenGL
        3DCore
        3DInput
        3DQuick
        3DQuickExtras
        3DQuickRender
    )
endif()

add_subdirectory(src)
