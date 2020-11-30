#pragma once
#include "Core/Public/FastRecycle.h"
#include "Render/RHI/Public/RHIDefines.h"

namespace MusaEngine
{
    class CRHIFrame: public CFastRecycle
    {
    public:
        CRHIFrame();
        ~CRHIFrame();
    public:
        uint32 MVertexShader;
        uint32 MFragmentShader;
    };
}
