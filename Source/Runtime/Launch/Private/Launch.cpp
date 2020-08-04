#include <stdio.h>
#include "Engine.h"
#include "Launch.h"
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

    while(!GPApp->IsQuit())
    {
        GPApp->Update();
    }

    GPApp->Finalize();

    return 0;
}
