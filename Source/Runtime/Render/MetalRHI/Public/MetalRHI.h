#pragma once
#include <vector>
#include <string>
#include "Render/RHI/Public/RHIDefines.h"
#include "Core/Public/RuntimeModule.hpp"

OBJC_CLASS(MetalRenderer);
ENGINE_BEGIN()

class FMetalRHI : public FRuntimeModule
{
public:
    FMetalRHI();
    virtual ~FMetalRHI();
    int32 Initialize() override;
    void Finalize() override;
    void Update() override;
    
    void SetMetalRenderer(MetalRenderer* Renderer);
    uint32 CompileShader(const std::string& Source, RHIShaderType CompileShaderType);
    void DrawDebug(uint32 VertexShaderIndex, uint32 FragmentShaderIndex);
private:
    MetalRenderer* MMetalRenderer;
};
ENGINE_END()
