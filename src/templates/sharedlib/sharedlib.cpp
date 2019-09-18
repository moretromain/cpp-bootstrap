#include "sharedlib.h"
#include <staticlib.h>

BEGIN_SHAREDLIB_NAMESPACE

void dummy()
{
    staticlib::dummy();
}

END_SHAREDLIB_NAMESPACE
