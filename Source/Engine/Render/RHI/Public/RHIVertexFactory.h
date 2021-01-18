#pragma once
#include "Common/Public/Buffer.h"
#include "Render/RHI/Public/RHIDefines.h"

namespace MusaEngine
{

class CRHIVertexFactory: public CFastRecycle
{
public:
    CRHIVertexFactory();
    ~CRHIVertexFactory();
    
public:
    void AddVertex(const RHIVertex& vertex);
    void AddIndice(const uint32 Indice);
    CBuffer* GetVertexBuffer();
    CBuffer* GetIndiceBuffer();
    uint32 GetIndiceCount();
    
private:
    std::vector<RHIVertex> MVertexs;
    std::vector<uint32> MIndices;
};

}
