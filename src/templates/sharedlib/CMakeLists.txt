target(sharedlib)

target_sources(
    sharedlib.cpp
    sharedlib.h
)

target_deps(
    staticlib
)

add_shared_library()
