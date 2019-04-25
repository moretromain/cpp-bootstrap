target(app)

target_sources(
    app.cpp
    app.h
)

target_deps(
    sharedlib
)

add_application()
