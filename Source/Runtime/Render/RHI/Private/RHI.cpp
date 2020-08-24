#include "AssetData/Public/AssetData.h"
#include "Render/OpenglDevice/Public/OpenglDevice.h"
#include "Render/MetalDevice/Public/MetalDevice.h"
#include "Render/RHI/Public/RHI.h"

ENGINE_BEGIN()
const std::string VS_SHADER_SOURCE_FILE = "Shader/colorvs.metal";
const std::string PS_SHADER_SOURCE_FILE = "Shader/colorps.metal";

FRHI::FRHI():
MUseOpengl(true),
MVertexShader(0),
MFragmentShader(0)
{

}

FRHI::~FRHI()
{

}

int32 FRHI::Initialize()
{
    MVertexShader = CompileShader(VS_SHADER_SOURCE_FILE, ShaderType::Vertex);
    MFragmentShader = CompileShader(PS_SHADER_SOURCE_FILE, ShaderType::Fragment);
    return 0;
}

void FRHI::Finalize()
{

}

void FRHI::Update()
{
    MetalDevice::Get()->Draw(MVertexShader, MFragmentShader);
}

uint32 FRHI::CompileShader(const std::string& File, ShaderType CompileShaderType)
{
    // Load the vertex shader source file into a text buffer.
    const std::string Source = GMODULE(FAssetData)->SyncOpenAndReadTextFileToString(File.c_str());
    if(Source.empty())
    {
        return 0;
    }
    
    return MetalDevice::Get()->CompileShader(Source, CompileShaderType);
}

ENGINE_END()
