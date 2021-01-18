#pragma once
#include "Core/Public/FastRecycle.h"
#include "Render/RHI/Public/RHIDefines.h"
#include "Render/RHI/Public/RHIPSO.h"

namespace MusaEngine
{

class CRHIPass: public CFastRecycle
{
public:
    CRHIPass();
    ~CRHIPass();
public:
    void PushPSO(CRHIPSO* PSO);
    std::vector<CRHIPSO*>& GetPSOList() { return MPSOList; }
private:
    std::vector<CRHIPSO*> MPSOList;
};

}
