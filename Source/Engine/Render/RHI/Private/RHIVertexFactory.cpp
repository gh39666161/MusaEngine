#include "Render/RHI/Public/RHIVertexFactory.h"

namespace MusaEngine
{

CRHIVertexFactory::CRHIVertexFactory()
{
    
}

CRHIVertexFactory::~CRHIVertexFactory()
{
    
}

void CRHIVertexFactory::AddVertex(const RHIVertex& vertex)
{
    MVertexs.push_back(vertex);
}

void CRHIVertexFactory::AddIndice(const uint32 Indice)
{
    MIndices.push_back(Indice);
}

CBuffer* CRHIVertexFactory::GetVertexBuffer()
{
    CBuffer* Buffer = new CBuffer(MVertexs.size()*sizeof(RHIVertex));
    memcpy(Buffer->GetData(), (uint8*)MVertexs.data(), Buffer->GetSize());
    return Buffer;
}

CBuffer* CRHIVertexFactory::GetIndiceBuffer()
{
    CBuffer* Buffer = new CBuffer(MIndices.size()*sizeof(uint32));
    memcpy(Buffer->GetData(), (uint8*)MIndices.data(), Buffer->GetSize());
    return Buffer;
}

uint32 CRHIVertexFactory::GetIndiceCount()
{
    return MIndices.size();
}

}
