#include "sharedlib.h"
#include <staticlib.h>

namespace sharedlib
{
    void dummy()
    {
        staticlib::dummy();
    }
}
