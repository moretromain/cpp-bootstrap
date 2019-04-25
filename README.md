# cpp-bootstrap
Cross-Platform CMake based minimalistic build system for C/C++

cpp-bootstrap is a thin wrapper around CMake that allows to easily create a multi-target project/solution that supports the following target types:
* imported/headers libraries
* static libraries (.a/.lib)
* shared libraries (.so/.dylib/.dll)
* console applications
* non-console application (WinMain/MacOS Bundle)

cpp-bootstrap is not intended to be a full-blown production-ready build system. It is more a quick-start template for designing small and cross-platform C++ codebase architectures without messing with IDE project wizards and other sources of joy and happiness.

The best way to use it is to embed the ```builder``` folder into a CMake tree, and then use the provided macros instead of pure CMake calls to populate the ```CMakeLists.txt``` files.

The builder is made of three main components:
* ```CMakeLists.txt```: the core CMakeLists that configures the builder, set a few variable and import all the necessary stuff into CMake
* ```platform.cmake```: a set of CMake macros and utilities to configure compiler and platform related stuff, mainly through the ```builder_configure_platform()``` macro
* ```target.cmake```: a set of CMake macros that are used to manage build targets (i.e. CMake projects, libraries, executables etc.)

Once the builder has been imported into a CMake tree, build targets are declared and populated through a set of CMake macros that take care of what their names suggest:
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
Those macros are just syntactic sugar over raw CMake calls that allow to quickly populate build targets with the usual stuff: sources, include directories, dependencies, preprocessor definitions etc.

Target dependencies can be either other targets or specific files (import libraries etc.), CMake takes care of managing dependencies like a champ.
The 'private' target macros declare target properties that won't be propagated through dependencies.

All those macros are just built on top of raw CMake projects, targets and their associated properties, so it is still possible to mix pure and custom CMake code in the ```CMakeLists.txt``` files. Feel free to browse the builder's code for more information.
The builder is fully compatible with CMake ```find_package()``` mechanism, and it is entirely possible to let CMake do all the heavy lifting when importing external dependencies, such as Boost, Qt or whatever else.

The builder takes care of setting basic C/CXX compiler flags that are suited for common development:
* enable C++17
* define DEBUG/NDEBUG
* set optimization flags
* enable/disable a few useful common compiler warnings/errors
* Windows
  * define UNICODE
  * define __cplusplus to the right version (required by some common libs, like boost)
  * define usual STL stuff (iterator debugging, deprecation warning etc.)
* MacOS
  * remove RPATH stuff to avoid absolute paths in there
  * define usual Clang/ObjC stuff (don't link with ObjC runtime etc.)

The builder will also generate a per-target ```target_api.h``` header for easier symbol management (defines a ```TARGET_API``` preprocessor macro that expands to the plaform specific stuff -dllexport/import, attribute visibility etc.-).

The root ```CMakeLists.txt``` shall at least include:

```
# Before doing anything CMake related, import the builder folder,
# this will prepare the builder to be used for whatever's coming next
add_subdirectory(builder)

# Create the main project, this will be the Visual Studio Solution, or the XCode Workspace etc.
project(${BUILDER_ROOT_PROJECT_NAME} C CXX)

# It's time to configure the build for the current platform, set a few compiler flags etc.
builder_configure_platform()

# Do whatever CMake stuff is required
...

# Import external dependencies
find_package(...)

# Add internal target folders
add_subdirectory(...)
```

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
