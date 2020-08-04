#include <stdio.h>
#include "Engine.h"
USE_ENGINE()

extern FApplication* GPApp;

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