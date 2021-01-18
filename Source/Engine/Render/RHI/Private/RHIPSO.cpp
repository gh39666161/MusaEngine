#include "Render/RHI/Public/RHIPSO.h"

namespace MusaEngine
{

CRHIPSO::CRHIPSO():
MVertexShader(IDX_NONE),
MFragmentShader(IDX_NONE),
MVertexFactory(nullptr)
{
    
}

CRHIPSO::~CRHIPSO()
{
    if (MVertexFactory)
    {
        delete MVertexFactory;
        MVertexFactory = nullptr;
    }
}

void CRHIPSO::SetVertexShader(int32 ShaderIndex)
{
    CHECK(ShaderIndex != IDX_NONE);
    MVertexShader = ShaderIndex;
}

void CRHIPSO::SetFragmentShader(int32 ShaderIndex)
{
    CHECK(ShaderIndex != IDX_NONE);
    MFragmentShader = ShaderIndex;
}

void CRHIPSO::SetVertexFactory(CRHIVertexFactory* VertexFactory)
{
    if (MVertexFactory)
    {
        delete MVertexFactory;
    }
    MVertexFactory = VertexFactory;
}

CRHIVertexFactory* CRHIPSO::GetVertexFactory()
{
    return MVertexFactory;
}

}
