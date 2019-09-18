#include "consoleapp.h"
#include <sharedlib.h>

BEGIN_CONSOLEAPP_NAMESPACE

END_CONSOLEAPP_NAMESPACE

// --

int main(int inArgc, char* inArgv[])
{
    sharedlib::dummy();
    return 0;
}