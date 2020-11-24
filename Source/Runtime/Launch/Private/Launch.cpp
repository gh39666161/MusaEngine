#include <stdio.h>
#include "Core/Public/Engine.h"
#include "Launch/Public/Launch.h"
using namespace MusaEngine;

namespace MusaEngine
{
    extern CApplication* GPApp;
}

int main(int argc, char* argv[])
{
    if (GPApp->Initialize() != 0)
    {
        printf("App Initialize failed, will exit now.");
        return 1;
    }
    CHECK(GMODULE(CAssetData)->Initialize() == 0);
    CHECK(GMODULE(CRHI)->Initialize() == 0);

    while(!GPApp->IsQuit())
    {
        GPApp->Update();
        GMODULE(CAssetData)->Update();
        GMODULE(CRHI)->Update();
    }
    
    GMODULE(CAssetData)->Finalize();
    GMODULE(CRHI)->Finalize();
    GPApp->Finalize();

    return 0;
}
