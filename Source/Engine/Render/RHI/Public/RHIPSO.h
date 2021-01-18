#pragma once
#include "Core/Public/FastRecycle.h"
#include "Render/RHI/Public/RHIDefines.h"
#include "Render/RHI/Public/RHIVertexFactory.h"

namespace MusaEngine
{

class CRHIPSO: public CFastRecycle
{
public:
    CRHIPSO();
    ~CRHIPSO();
public:
    void SetVertexShader(int32 ShaderIndex);
    void SetFragmentShader(int32 ShaderIndex);
    int32 GetVertexShader() { return MVertexShader; }
    int32 GetFragmentShader() { return MFragmentShader; }
    void SetVertexFactory(CRHIVertexFactory* VertexFactory);
    CRHIVertexFactory* GetVertexFactory();
    
private:
    int32 MVertexShader;
    int32 MFragmentShader;
    CRHIVertexFactory* MVertexFactory;
};

}
