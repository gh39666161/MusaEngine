#pragma once
#include <string>
#include <atomic>
#include "Render/RHI/Public/RHIDefines.h"
#include "Core/Public/RuntimeModule.hpp"
#include "Render/RHI/Public/RHIFrame.h"

namespace MusaEngine
{

class CRHI : public CRuntimeModule
{
public:
    CRHI();
    virtual ~CRHI();
    virtual void DrawDebug() = 0;
    virtual void BeginFrame();
    virtual void EndFrame();
    CRHIFrame* GetDrawFrame();
    void FinishDrawFrame();
protected:
    virtual void SetCurrentFrame(CRHIFrame* Frame);
public:
    static CRHI* GetDerived();
private:
    static bool MUseOpengl;
    
private:
    int32 MDrawFrameIndex;
    int32 MRenderFrameIndex;
    std::atomic<bool> MFrameReady;
    CRHIFrame* MFrameCircleQueue[MAX_FRAME_BUFF_COUNT] = { nullptr };
    std::atomic_flag MFrameIndexLock[MAX_FRAME_BUFF_COUNT] = { ATOMIC_FLAG_INIT };
};

}
