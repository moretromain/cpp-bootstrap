# cpp-bootstrap

[![Build Status](https://travis-ci.com/moretromain/cpp-bootstrap.svg?branch=master)](https://travis-ci.com/moretromain/cpp-bootstrap)

Cross-Platform CMake based minimalistic build system for C/C++

cpp-bootstrap is a thin wrapper around CMake that allows to easily create a multi-target project/solution that supports the following target types:
* imported/headers libraries
* static libraries (.a/.lib)
* shared libraries (.so/.dylib/.dll)
* console applications
* non-console application (WinMain/MacOS Bundle)

cpp-bootstrap is not intended to be a full-blown production-ready build system. It is more a quick-start template for designing small and cross-platform C++ codebase architectures without messing with IDE project wizards and other sources of joy and happiness.

## What's inside and how to use it ?
The best way to use it is to embed the ```builder``` folder into a CMake tree, and then use the provided macros instead of pure CMake calls to populate the ```CMakeLists.txt``` files.

The builder is made of three main components:
* ```CMakeLists.txt```: the core CMakeLists that configures the builder, set a few variable and import all the necessary stuff into CMake
* ```platform.cmake```: a set of CMake macros and utilities to configure compiler and platform related stuff, mainly through the ```builder_configure_platform()``` macro
* ```target.cmake```: a set of CMake macros that are used to manage build targets (i.e. CMake projects, libraries, executables etc.)

Most of the time, there is a one-one mapping between a CMake project and a generated build target, i.e. one project leads to one build target. And most of the time, build targets are all made of the same wood: source files, include directories, preprocessor defines, dependencies (target or libraries), and nothing more.
The builder's target notion is built on top of this. A target is a simple CMake project with a few associated variables that leads to a generated build target.
You just have to tell the builder which is which, and then let it translate everything to the CMake world.

To do so, build targets are declared and populated through a set of CMake macros that take care of what their names suggest:
```
target()
target_include_dirs()
target_private_include_dirs()
target_interface_include_dirs()
target_sources()
target_defs()
target_private_defs()
target_interface_defs()
target_deps()
target_private_deps()
target_interface_deps()
target_features()
target_private_features()
target_interface_features()
target_info_plist()
target_output_name()
import_static_library()
import_shared_library()
import_headers_library()
add_external_headers_library()
add_external_static_library()
add_external_shared_library()
add_headers_library()
add_static_library()
add_shared_library()
add_console_application()
add_application()
```
Those macros are just syntactic sugar over raw CMake calls that allow to quickly populate build targets with the usual stuff: sources, include directories, dependencies, preprocessor definitions etc.

Target dependencies can be either other targets or specific files (import libraries etc.), CMake takes care of managing dependencies like a champ.
The 'private' target macros declare target properties that won't be propagated through dependencies.
The 'interface' target macros declare target properties that will be propagated through CMake interface targets.

All those macros are just built on top of raw CMake projects, targets and their associated properties, so it is still possible to mix pure and custom CMake code in the ```CMakeLists.txt``` files. Feel free to browse the builder's code for more information.
The builder is fully compatible with CMake ```find_package()``` mechanism, and it is entirely possible to let CMake do all the heavy lifting when importing external dependencies, such as Boost, Qt or whatever else.

## How does the builder impact my build ?

The builder takes care of setting basic C/CXX compiler flags that are suited for common development:
* enable C++17
* define DEBUG/NDEBUG
* set optimization flags
* enable/disable a few useful common compiler warnings/errors
* Windows
  * define UNICODE
  * define __cplusplus to the right version (required by some common libs, like boost)
  * define usual STL stuff (iterator debugging, deprecation warnings etc.)
* MacOS
  * remove RPATH stuff to avoid absolute paths in there
  * define usual Clang/ObjC stuff (don't link with ObjC runtime etc.)

The builder will also generate a per-target ```target_api.h``` and ```target_namesace.h``` header set for easier namespace and symbol management (defines a ```TARGET_API``` preprocessor macro that expands to the plaform specific stuff -dllexport/import, attribute visibility etc.-).

## What are the bare requirements in my CMake code ?

### Root ```CMakeLists.txt```

The root ```CMakeLists.txt``` shall at least include:

```
# The builder uses very basic CMake stuff, any 3.x version should do..
cmake_minimum_required(...)

# Before doing anything CMake related, import the builder folder,
# this will prepare the builder to be used for whatever's coming next
add_subdirectory(builder)

# Create the main project, this will be the Visual Studio Solution,
# the XCode Workspace or the MakeFile root target
project(${BUILDER_ROOT_PROJECT_NAME} C CXX)

# It's time to configure the builder for the current platform, set a few compiler flags etc.
builder_configure_platform()

# Do whatever CMake stuff is required, more compiler options,
# shared variables, checks, cache magic...
...

# Import external dependencies, if any
find_package(...)

# Add internal folders as in any CMake tree
add_subdirectory(...)
```

### Per-folder ```CMakeLists.txt```

A basic ```CMakeLists.txt``` that declares one target would look like:

```
# Declare a new target called 'MyTarget'
target(MyTarget)

# Add a couple of source files to it
target_sources(
  myTarget.cpp
  myTarget.h
)

# Set private preprocessor definitions that won't be propagated through dependencies (hidden)
target_private_defs(
  USE_SOME_STUFF_BUT_DONT_TELL_OTHERS=1
)

# Set preprocessor definitions that will be propagated through dependencies (exposed)
target_defs(
  USE_SOME_STUFF_AND_TELL_THE_WORLD=1
)

# Add a couple of dependencies to other previously defined or imported targets
target_deps(
  MyOtherTarget
  Boost::system
)

# Add platform-specific dependencies to additional libraries/frameworks
if(WINDOWS_BUILD)
  target_deps(
    lib/someWindowsLib.lib
  )
elseif(MACOS_BUILD)
  target_deps(
    "--framework CoreAwesome"
  )
endif()

# Set a custom name for the build output (optional)
target_output_name("My Target")

# And finally, tell CMake to gather all the information we set so far for our target,
# and create a shared library build target out of all this
add_shared_library()
```

There can be more than one target per ```CMakeLists.txt```, but bear in mind that builder's ```target()``` calls CMake's ```project()```, and once you declared a target, you can only add stuff to it, not change, interact or remove anything. If you need multiple build targets, the best way to achieve this is to declare multiple ```target()s``` with different names.
You can always share things through CMake variables, or even CMake's cache if required. There is no added magic here, there's plenty of it in CMake already.

See template projects in the ```src``` folder for more examples.

## Miscellaneous

Requirements:
* Windows, MacOS or Linux
* CMake (any version should do, but hey, pick the last one it has a nicer logo :))
* Modern C++ Toolchain (MSVC, Clang/LLVM, GCC, with C++17 support)

Build:
* Use ```build-[platform]``` script to automatically launch the CMake GUI with predefined out-of-tree build folders

Todo:
* More examples and templates
