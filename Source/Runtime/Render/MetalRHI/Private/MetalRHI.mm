#include "Render/MetalRHI/Public/MetalRenderer.h"
#include "Render/MetalRHI/Public/MetalRHI.h"
ENGINE_BEGIN()

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

uint32 FMetalRHI::CompileShader(const std::string& Source,  RHIShaderType CompileShaderType)
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
    return 0;
}

void FMetalRHI::DrawDebug(uint32 VertexShaderIndex, uint32 FragmentShaderIndex)
{
    [MMetalRenderer drawDebug:VertexShaderIndex Fragment:FragmentShaderIndex];
}

ENGINE_END()
