#include <stdio.h>
#include "Launch/Public/Launch.h"
using namespace MusaEngine;

namespace MusaEngine
{

CApplication* CLaunch::MGApp = nullptr;
bool CLaunch::MExist = false;

CApplication* CLaunch::GetApp()
{
    return MGApp;
}

bool CLaunch::IsExist()
{
    return MExist;
}

int32 CLaunch::Init()
{
    if (GetApp()->Initialize() != 0)
    {
        printf("App Initialize failed, will exit now.");
        return 1;
    }
    
    CHECK(GMODULE(CAsset)->Initialize() == 0);
    CHECK(GDMODULE(CRHI)->Initialize() == 0);
    return 0;
}

void CLaunch::Loop()
{
    GetApp()->Update();
    GMODULE(CAsset)->Update();
    GDMODULE(CRHI)->DrawDebug();
    GDMODULE(CRHI)->Update();
}

void CLaunch::Exit()
{
    GMODULE(CAsset)->Finalize();
    GDMODULE(CRHI)->Finalize();
    GetApp()->Finalize();
    MExist = true;
}

void CLaunch::Launch(CApplication* GApp)
{
    MGApp = GApp;
    CHECK(MGApp != nullptr);
    
    CHECK(Init() == 0);
    while(!GetApp()->IsQuit())
    {
        Loop();
    }
    Exit();
}

}
