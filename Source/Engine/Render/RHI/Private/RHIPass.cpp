#include "Render/RHI/Public/RHIPass.h"

namespace MusaEngine
{

CRHIPass::CRHIPass()
{
    
}

CRHIPass::~CRHIPass()
{
    for (CRHIPSO* PSO : MPSOList)
    {
        if (PSO)
        {
            delete PSO;
        }
    }
    MPSOList.clear();
}

void CRHIPass::PushPSO(CRHIPSO* PSO)
{
    MPSOList.push_back(PSO);
}

}
