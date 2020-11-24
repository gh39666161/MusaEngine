#pragma once
#include <vector>
#include <string>
#include "Render/RHI/Public/RHIDefines.h"
#include "Core/Public/RuntimeModule.hpp"

OBJC_CLASS(MetalRenderer);
namespace MusaEngine
{
    class CMetalRHI : public CRuntimeModule
    {
    public:
        CMetalRHI();
        virtual ~CMetalRHI();
        int32 Initialize() override;
        void Finalize() override;
        void Update() override;
        
        void SetMetalRenderer(MetalRenderer* Renderer);
        int32 CompileShader(const std::string& Source, RHIShaderType CompileShaderType);
        void DrawDebug(int32 VertexShaderIndex, int32 FragmentShaderIndex);
    private:
        MetalRenderer* MMetalRenderer;
    };
}
