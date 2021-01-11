#pragma once
#include "Core/Public/Core.h"
#include "Core/Public/FastRecycle.h"
#include "Core/Public/StaticClass.h"
#include "Platform/Public/Application.h"
#include "Asset/Public/Asset.h"
#include "Render/MetalRHI/Public/MetalRHI.h"

namespace MusaEngine
{
    class CGEngine : public SStaticClass
    {
    public:
        static void Start();
        static bool IsExist();
        static void ReqExist();
    private:
        static int32 Init();
        static void Loop();
        static void Exit();
    private:
        static bool MReqExist;
        static bool MExist;
    };
}