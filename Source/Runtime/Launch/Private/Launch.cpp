#include <stdio.h>
#include "Core/Public/Engine.h"
#include "Launch/Public/Launch.h"
USE_ENGINE()

ENGINE_BEGIN()
extern FApplication* GPApp;
ENGINE_END()

int main(int argc, char* argv[])
{
    if (GPApp->Initialize() != 0)
    {
        printf("App Initialize failed, will exit now.");
        return 1;
    }
    CHECK(GMODULE(FAssetData)->Initialize() == 0);
    CHECK(GMODULE(FRHI)->Initialize() == 0);

    while(!GPApp->IsQuit())
    {
        GPApp->Update();
        GMODULE(FAssetData)->Update();
        GMODULE(FRHI)->Update();
    }
    
    GMODULE(FAssetData)->Finalize();
    GMODULE(FRHI)->Finalize();
    GPApp->Finalize();

    return 0;
}
