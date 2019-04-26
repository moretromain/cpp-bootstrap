#include "app.h"
#include <sharedlib.h>
#if SYS_WINDOWS
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#endif

#if SYS_WINDOWS
int WINAPI WinMain(HINSTANCE inInstance, HINSTANCE inPrevInstance,
                   LPSTR inCommandLine, int inShowCommand)
{
    sharedlib::dummy();
    return 0;
}
#elif SYS_MACOS
int main(int inArgc, char* inArgv[])
{
    sharedlib::dummy();
    return 0;
}
#elif SYS_LINUX
int main(int inArgc, char* inArgv[])
{
    sharedlib::dummy();
    return 0;
}
#endif
