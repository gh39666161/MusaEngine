#include "Asset/Public/Asset.h"
#include "Render/MetalRHI/Public/MetalRenderer.h"
#include "Render/MetalRHI/Public/MetalRHI.h"

namespace MusaEngine
{

const std::string VS_SHADER_SOURCE_FILE = "Shader/mainvs.metal";
const std::string PS_SHADER_SOURCE_FILE = "Shader/mainvs.metal";

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

void CMetalRHI::BeginFrame()
{
    CRHI::BeginFrame();
}

void CMetalRHI::EndFrame()
{
    CRHI::EndFrame();
}

void CMetalRHI::DrawDebug()
{
    BeginFrame();
    
    BeginPass();
    CRHIPSO* PSO = new CRHIPSO();
    PSO->SetVertexShader(MVertexShader);
    PSO->SetFragmentShader(MFragmentShader);
    CRHIVertexFactory* VertexFactory = new CRHIVertexFactory();
    RHIVertex MyVertex[3];
    MyVertex[0].Pos = Vec4(1.0f, 1.0f, 0.0f, 1.0f);
    MyVertex[1].Pos = Vec4(-1.0f, -1.0f, 0.0f, 1.0f);
    MyVertex[2].Pos = Vec4(1.0f, -1.0f, 0.0f, 1.0f);
    for (int i = 0; i < 3; i++)
    {
        VertexFactory->AddVertex(MyVertex[i]);
        VertexFactory->AddIndice(i);
    }
    PSO->SetVertexFactory(VertexFactory);
    GetCurrentPass()->PushPSO(PSO);
    
    PSO = new CRHIPSO();
    PSO->SetVertexShader(MVertexShader);
    PSO->SetFragmentShader(MFragmentShader);
    VertexFactory = new CRHIVertexFactory();
    RHIVertex MyVertex2[3];
    MyVertex2[0].Pos = Vec4(0.0f, 0.0f, 0.0f, 1.0f);
    MyVertex2[1].Pos = Vec4(0.0f, 1.0f, 0.0f, 1.0f);
    MyVertex2[2].Pos = Vec4(-1.0f, 0.0f, 0.0f, 1.0f);
    for (int i = 0; i < 3; i++)
    {
        VertexFactory->AddVertex(MyVertex2[i]);
        VertexFactory->AddIndice(i);
    }
    PSO->SetVertexFactory(VertexFactory);
    GetCurrentPass()->PushPSO(PSO);
    EndPass();

    EndFrame();
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
