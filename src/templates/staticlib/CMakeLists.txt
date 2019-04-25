target(staticlib)

target_sources(
    staticlib.cpp
    staticlib.h
)

target_deps(
    core
)

add_static_library()
