target(staticlib)

target_sources(
    staticlib.cpp
    staticlib.h
)

target_deps(
    core
	interfacelib
)

add_static_library()
