#include "Core/Public/Engine.h"

namespace MusaEngine
{

bool CGEngine::MReqExist = false;
bool CGEngine::MExist = false;

void CGEngine::ReqExist()
{
    MReqExist = true;
}

bool CGEngine::IsExist()
{
    return MExist;
}

int32 CGEngine::Init()
{
    CHECK(GMODULE(CAsset)->Initialize() == 0);
    CHECK(GDMODULE(CRHI)->Initialize() == 0);
    return 0;
}

void CGEngine::Loop()
{
    GMODULE(CAsset)->Update();
    GDMODULE(CRHI)->DrawDebug();
    GDMODULE(CRHI)->Update();
}

void CGEngine::Exit()
{
    GMODULE(CAsset)->Finalize();
    GDMODULE(CRHI)->Finalize();
    MExist = true;
}

void CGEngine::Start()
{
    CHECK(Init() == 0);
    while(!MReqExist)
    {
        Loop();
    }
    Exit();
}

}
