macro(builder_import_qt_modules)
    set(QTDIR $ENV{QTDIR})
    if (NOT QTDIR)
        message(SEND_ERROR "Cannot find environment variable 'QTDIR'.\nPlease set it to the current platform QT directory.")
    endif()

    set(BUILDER_QTDIR ${QTDIR} CACHE PATH "Qt base directory.")
    
    list(APPEND CMAKE_PREFIX_PATH "${BUILDER_QTDIR}")
    foreach(module ${ARGN})
        find_package(Qt5${module} REQUIRED)
    endforeach()
endmacro()
