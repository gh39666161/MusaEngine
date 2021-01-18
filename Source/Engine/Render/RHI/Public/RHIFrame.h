#pragma once
#include "Core/Public/FastRecycle.h"
#include "Render/RHI/Public/RHIDefines.h"
#include "Render/RHI/Public/RHIPass.h"

namespace MusaEngine
{

class CRHIFrame: public CFastRecycle
{
public:
    CRHIFrame();
    ~CRHIFrame();
    
public:
    void BeginPass();
    void EndPass();
    CRHIPass* GetCurrentPass() { return MCurrentPass; }
    std::vector<CRHIPass*>& GetPassList() { return MPassList; }
private:
    std::vector<CRHIPass*> MPassList;
    CRHIPass* MCurrentPass;
};

}
