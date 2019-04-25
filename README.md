# cpp-bootstrap
Cross-Platform CMake based minimalistic build system for C/C++

cpp-bootstrap is a thin wrapper around CMake that allows to easily create a multi-target project/solution that supports the following target types:
* imported/headers libraries
* static libraries (.a/.lib)
* shared libraries (.so/.dylib/.dll)
* console applications
* non-console application (WinMain/MacOS Bundle)

Targets are declared and populated through a set of CMake macros that take care of what their names suggest:
```
target()
target_include_dirs()
target_private_include_dirs()
target_sources()
target_defs()
target_private_defs()
target_deps()
target_private_deps()
target_info_plist()
target_output_name()
import_static_library()
import_shared_library()
import_headers_library()
add_headers_library()
add_static_library()
add_shared_library()
add_console_application()
add_application()
```

Target dependencies can be either other targets or specific files (import libraries etc.), CMake take care of managing dependencies.
The 'private' target macros declare target properties that won't be propagated through dependencies.

All those macros are just built on top of raw CMake project, target and their associated properties, so it is still possible to mix pure and custom CMake code in the CMakeLists.txt files.
The builder is not incompatible with CMake ```find_package()``` mechanism, and it is entirely possible to use it to import external dependencies, such as Boost, Qt or whatever else.

The builder takes care of setting basic C/CXX compiler flags that are suited for common development:
* enable C++17
* define DEBUG/NDEBUG
* set optimization flags
* enable/disable a few useful common compiler warnings/errors
* Windows:
  * define UNICODE
  * define __cplusplus to the right version (required by some common libs, like boost)
  * define usual STL stuff (iterator debugging, deprecation warning etc.)
* MacOS
  * remove RPATH stuff to avoid absolute paths in there
  * define usual Clang/ObjC stuff (don't link with ObjC runtime etc.)

The builder will also generate a per-target ```target_api.h``` header for easier symbol management (defines a ```TARGET_API``` preprocessor macro that expands to the plaform specific stuff -dllexport/import, attribute visibility etc.-).

A basic ```CMakeLists.txt``` would look like:

```
target(MyTarget)

target_sources(
  myTarget.cpp
  myTarget.h
)

target_private_defs(
  USE_SOME_STUFF_BUT_DONT_TELL_OTHERS=1
)

target_defs(
  USE_SOME_STUFF_AND_TELL_THE_WORLD=1
)

target_deps(
  MyOtherTarget
  Boost::system
)

if(WINDOWS_BUILD)
  target_deps(
    lib/someWindowsLib.lib
  )
elseif(MACOS_BUILD)
  target_deps(
    "--framework CoreAwesome"
  )
endif()

add_shared_library()
```

See template projects in the src folder for more examples.

Requirements:
* CMake
* Modern C++ Toolchain (MSVC, Clang/LLVM, GCC, with C++17 support)

Build:
* Use ```build-[platform]``` script to automatically launch the CMake GUI with predefined build folders
