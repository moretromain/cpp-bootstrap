target(app)

target_sources(
    app.cpp
    app.h
)

target_deps(
    sharedlib
)

target_info_plist(
    resources/info.plist.in
)

target_output_name("Template APP")

add_application()
