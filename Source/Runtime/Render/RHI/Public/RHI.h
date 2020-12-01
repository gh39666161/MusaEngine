#pragma once
#include <string>
#include "Render/RHI/Public/RHIDefines.h"
#include "Core/Public/RuntimeModule.hpp"
#include "Render/RHI/Public/RHIFrame.h"

namespace MusaEngine
{
    class CRHI : public CRuntimeModule
    {
    public:
        CRHI();
        virtual ~CRHI();
        virtual void DrawDebug() = 0;
        virtual CRHIFrame* GetFrame();
    public:
        static CRHI* GetDerived();
    private:
        static bool MUseOpengl;
    protected:
        CRHIFrame* MFrame;
    };
}
