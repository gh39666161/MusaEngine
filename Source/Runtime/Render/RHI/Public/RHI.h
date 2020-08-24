#pragma once
#include <string>
#include "Core/Public/RuntimeModule.hpp"

ENGINE_BEGIN()

enum ShaderType
{
    Vertex,
    Fragment
};

class FRHI : public FRuntimeModule
{
public:
    FRHI();
    virtual ~FRHI();
    int32 Initialize() override;
    void Finalize() override;
    void Update() override;
    uint32 CompileShader(const std::string& File, ShaderType CompileShaderType);
private:
    bool MUseOpengl;
    uint32 MVertexShader;
    uint32 MFragmentShader;
};
ENGINE_END()
