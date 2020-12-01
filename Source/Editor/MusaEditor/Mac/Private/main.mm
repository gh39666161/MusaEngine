#include "Core/Public/Engine.h"
#include "Launch/Public/Launch.h"
#include "MusaEditor/Mac/Public/MetalApplication.h"
using namespace MusaEngine;

int main(int argc, const char * argv[])
{
    CMetalApplication GMetalApp;
    CLaunch::Launch(static_cast<CApplication*>(&GMetalApp));
    return 0;
}
