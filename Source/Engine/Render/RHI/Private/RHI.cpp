#include "Render/RHI/Public/RHI.h"
#include "Render/MetalRHI/Public/MetalRHI.h"

namespace MusaEngine
{
    bool CRHI::MUseOpengl = false;

    CRHI::CRHI()
    {
        MFrame = new CRHIFrame();
    }

    CRHI::~CRHI()
    {
        delete MFrame;
        MFrame = nullptr;
    }

    CRHI* CRHI::GetDerived()
    {
        if (!MUseOpengl)
        {
            return GMODULE(CMetalRHI);
        }
        return nullptr;
    }

    CRHIFrame* CRHI::GetFrame()
    {
        return MFrame;
    }
}
