#include "Render/RHI/Public/RHIFrame.h"

namespace MusaEngine
{

CRHIFrame::CRHIFrame():
MCurrentPass(nullptr)
{
    
}

CRHIFrame::~CRHIFrame()
{
    if (MCurrentPass)
    {
        delete MCurrentPass;
        MCurrentPass = nullptr;
    }
    
    for (CRHIPass* Pass : MPassList)
    {
        if (Pass)
        {
            delete Pass;
        }
    }
    MPassList.clear();
}

void CRHIFrame::BeginPass()
{
    if (MCurrentPass)
    {
        delete MCurrentPass;
    }
    MCurrentPass = new CRHIPass();
}

void CRHIFrame::EndPass()
{
    if (MCurrentPass)
    {
        MPassList.push_back(MCurrentPass);
    }
    MCurrentPass = nullptr;
}

}
