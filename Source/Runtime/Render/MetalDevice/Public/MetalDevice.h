#pragma once
#include <vector>
#include <string>
#include "Render/RHI/Public/RHI.h"

OBJC_CLASS(MetalView);
OBJC_CLASS(CAMetalDrawable);
ENGINE_BEGIN()

class MetalDevice
{
public:
    MetalDevice();
    ~MetalDevice();
    void Initialize(MetalView* View);
    uint32 CompileShader(const std::string& Source, ShaderType CompileShaderType);
    void* GetShader(uint32 Index);
    static MetalDevice* Get();
    void Draw(uint32 VertexShaderIndex, uint32 FragmentShaderIndex);
private:
    MetalView* MMetalView;
    std::vector<void*> MShaders;
};
ENGINE_END()
