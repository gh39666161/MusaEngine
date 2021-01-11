#pragma once
#include "Core/Public/Engine.h"
namespace MusaEngine
{
    class CLaunch : public SStaticClass
    {
    public:
        static void Launch(CApplication* GApp);
        static CApplication* GetApp();
        static bool IsExist();
    private:
        static int32 Init();
        static void Loop();
        static void Exit();
    private:
        static CApplication* MGApp;
        static bool MExist;
    };
}
