#pragma once
#include <string>
#include "Render/RHI/Public/RHIDefines.h"
#include "Render/MetalRHI/Public/MetalRHI.h"
#include "Core/Public/RuntimeModule.hpp"
ENGINE_BEGIN()

class FRHI : public FRuntimeModule
{
public:
    FRHI();
    virtual ~FRHI();
    int32 Initialize() override;
    void Finalize() override;
    void Update() override;
    uint32 CompileShader(const std::string& File, RHIShaderType CompileShaderType);
private:
    bool MUseOpengl;
    uint32 MVertexShader;
    uint32 MFragmentShader;
};
ENGINE_END()
