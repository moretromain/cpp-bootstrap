target(consoleapp)

target_sources(
    consoleapp.cpp
    consoleapp.h
)

target_deps(
    sharedlib
)

add_console_application()
