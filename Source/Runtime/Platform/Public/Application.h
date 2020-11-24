#pragma once
#include "Core/Public/Core.h"
#include "Core/Public/RuntimeModule.hpp"

namespace MusaEngine
{
    class CApplication : public CRuntimeModule
    {
    public:
        CApplication();
        virtual int32 Initialize();
        virtual void Finalize();
        virtual void Update();
        virtual bool IsQuit();
    protected:
        bool MBQuit;
    };
}

