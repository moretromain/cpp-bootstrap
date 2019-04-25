#include "core_api.h"

#if defined(_WIN32) || defined(_WIN64)
  #define SYS_WINDOWS 1
  #ifdef _WIN64
    #define SYS_64BIT 1
  #else
    #define SYS_32BIT 1
  #endif
#elif defined(__APPLE__) && defined(__MACH__)
  #define SYS_MACOS 1
  #ifdef __LP64__
    #define SYS_64BIT 1
  #else
    #define SYS_32BIT 1
  #endif
#elif defined(__linux__)
  #define SYS_LINUX 1
  #ifdef __LP64__
    #define SYS_64BIT 1
  #else
    #define SYS_32BIT 1
  #endif
#else
#error "Unsupported platform"
#endif

#if defined(_DEBUG) || !defined(NDEBUG)
  #define SYS_DEBUG 1
#else
  #define SYS_RELEASE 1
#endif

#define SYS_NON_COPYABLE(Class)                 \
    Class(const Class&) = delete;               \
    Class& operator=(const Class&) = delete;    \

#define SYS__STRINGIFY(LitteralString)      #LitteralString
#define SYS_STRINGIFY(LitteralString)       SYS__STRINGIFY(LitteralString)

#define SYS__WSTRINGIFY(LitteralString)     L##LitteralString
#define SYS_WSTRINGIFY(LitteralString)      SYS__WSTRINGIFY(LitteralString)

#define SYS_WIDEN(X)                        L##X
