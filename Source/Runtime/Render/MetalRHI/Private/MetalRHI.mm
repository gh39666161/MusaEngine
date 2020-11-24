#include "Render/MetalRHI/Public/MetalRenderer.h"
#include "Render/MetalRHI/Public/MetalRHI.h"

namespace MusaEngine
{
    CMetalRHI::CMetalRHI()
    {
        
    }

    CMetalRHI::~CMetalRHI()
    {

    }

    int32 CMetalRHI::Initialize()
    {
        return 0;
    }

    void CMetalRHI::Finalize()
    {

    }

    void CMetalRHI::Update()
    {
    }

    void CMetalRHI::SetMetalRenderer(MetalRenderer* Renderer)
    {
        MMetalRenderer = Renderer;
    }

    int32 CMetalRHI::CompileShader(const std::string& Source,  RHIShaderType CompileShaderType)
    {
        NSString* ShaderSource = [NSString stringWithCString:Source.c_str() encoding:[NSString defaultCStringEncoding]];
        if (CompileShaderType == RHIShaderType::Vertex)
        {
            return [MMetalRenderer compileShader:ShaderSource functionName:@"MainVS"];
        }
        else if (CompileShaderType == RHIShaderType::Fragment)
        {
            return [MMetalRenderer compileShader:ShaderSource functionName:@"MainPS"];
        }
        return IDX_NONE;
    }

    void CMetalRHI::DrawDebug(int32 VertexShaderIndex, int32 FragmentShaderIndex)
    {
        [MMetalRenderer drawDebug:VertexShaderIndex Fragment:FragmentShaderIndex];
    }
}
