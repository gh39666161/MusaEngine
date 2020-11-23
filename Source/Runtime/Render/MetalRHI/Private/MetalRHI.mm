#include "Render/MetalRHI/Public/MetalRenderer.h"
#include "Render/MetalRHI/Public/MetalRHI.h"

namespace MusaEngine
{
    FMetalRHI::FMetalRHI()
    {
        
    }

    FMetalRHI::~FMetalRHI()
    {

    }

    int32 FMetalRHI::Initialize()
    {
        return 0;
    }

    void FMetalRHI::Finalize()
    {

    }

    void FMetalRHI::Update()
    {
    }

    void FMetalRHI::SetMetalRenderer(MetalRenderer* Renderer)
    {
        MMetalRenderer = Renderer;
    }

    int32 FMetalRHI::CompileShader(const std::string& Source,  RHIShaderType CompileShaderType)
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

    void FMetalRHI::DrawDebug(int32 VertexShaderIndex, int32 FragmentShaderIndex)
    {
        [MMetalRenderer drawDebug:VertexShaderIndex Fragment:FragmentShaderIndex];
    }
}
