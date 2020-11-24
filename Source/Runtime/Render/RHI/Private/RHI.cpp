#include "AssetData/Public/AssetData.h"
#include "Render/MetalRHI/Public/MetalRHI.h"
#include "Render/RHI/Public/RHI.h"

namespace MusaEngine
{
    const std::string VS_SHADER_SOURCE_FILE = "Shader/colorvs.metal";
    const std::string PS_SHADER_SOURCE_FILE = "Shader/colorps.metal";

    CRHI::CRHI():
    MUseOpengl(true),
    MVertexShader(0),
    MFragmentShader(0)
    {

    }

    CRHI::~CRHI()
    {

    }

    int32 CRHI::Initialize()
    {
        MVertexShader = CompileShader(VS_SHADER_SOURCE_FILE, RHIShaderType::Vertex);
        MFragmentShader = CompileShader(PS_SHADER_SOURCE_FILE, RHIShaderType::Fragment);
        return 0;
    }

    void CRHI::Finalize()
    {

    }

    void CRHI::Update()
    {
        GMODULE(CMetalRHI)->DrawDebug(MVertexShader, MFragmentShader);
    }

    uint32 CRHI::CompileShader(const std::string& File, RHIShaderType CompileShaderType)
    {
        // Load the vertex shader source file into a text buffer.
        const std::string Source = GMODULE(CAssetData)->SyncOpenAndReadTextFileToString(File.c_str());
        if(Source.empty())
        {
            return 0;
        }
        
        return GMODULE(CMetalRHI)->CompileShader(Source, CompileShaderType);
    }
}
