#include "Asset/Public/Asset.h"
#include "Render/MetalRHI/Public/MetalRenderer.h"
#include "Render/MetalRHI/Public/MetalRHI.h"

namespace MusaEngine
{
    const std::string VS_SHADER_SOURCE_FILE = "Shader/colorvs.metal";
    const std::string PS_SHADER_SOURCE_FILE = "Shader/colorps.metal";

    CMetalRHI::CMetalRHI():
    CRHI(),
    MVertexShader(0),
    MFragmentShader(0)
    {
        
    }

    CMetalRHI::~CMetalRHI()
    {

    }

    int32 CMetalRHI::Initialize()
    {
        MVertexShader = CompileShader(VS_SHADER_SOURCE_FILE, RHIShaderType::Vertex);
        MFragmentShader = CompileShader(PS_SHADER_SOURCE_FILE, RHIShaderType::Fragment);
        return 0;
    }

    void CMetalRHI::Finalize()
    {
        [MMetalRenderer release];
        MMetalRenderer = nil;
    }

    void CMetalRHI::Update()
    {
    }

    void CMetalRHI::DrawDebug()
    {
        MFrame->MVertexShader = MVertexShader;
        MFrame->MFragmentShader = MFragmentShader;
        MFrame->MIsOk = true;
    }

    void CMetalRHI::SetMetalRenderer(MetalRenderer* Renderer)
    {
        MMetalRenderer = Renderer;
    }

    int32 CMetalRHI::CompileShader(const std::string& File,  RHIShaderType CompileShaderType)
    {
        // Load the vertex shader source file into a text buffer.
        const std::string Source = GMODULE(CAsset)->SyncOpenAndReadTextFileToString(File.c_str());
        if(Source.empty())
        {
            return 0;
        }
        
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
}
