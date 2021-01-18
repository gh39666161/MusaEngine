#pragma once
#include <vector>
#include <string>
#include "Render/RHI/Public/RHI.h"

OBJC_CLASS(MetalRenderer);
namespace MusaEngine
{

class CMetalRHI : public CRHI
{
public:
    CMetalRHI();
    virtual ~CMetalRHI();
    int32 Initialize() override;
    void Finalize() override;
    void Update() override;
    virtual void BeginFrame() override;
    virtual void EndFrame() override;
    
    void DrawDebug() override;
    
    void SetMetalRenderer(MetalRenderer* Renderer);
    int32 CompileShader(const std::string& File, RHIShaderType CompileShaderType);
private:
    MetalRenderer* MMetalRenderer;
    
    uint32 MVertexShader;
    uint32 MFragmentShader;
};

}
