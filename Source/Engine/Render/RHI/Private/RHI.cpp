#include <thread>
#include "Render/RHI/Public/RHI.h"
#include "Render/MetalRHI/Public/MetalRHI.h"

namespace MusaEngine
{

bool CRHI::MUseOpengl = false;

CRHI::CRHI():
MDrawFrameIndex(-1),
MRenderFrameIndex(-1),
MFrameReady(false)
{
}

CRHI::~CRHI()
{
}

CRHI* CRHI::GetDerived()
{
    if (!MUseOpengl)
    {
        return GMODULE(CMetalRHI);
    }
    return nullptr;
}

void CRHI::BeginFrame()
{
    // increase render frame first.
    MRenderFrameIndex = (MRenderFrameIndex + 1) % MAX_FRAME_BUFF_COUNT;
    
    // test this frame is been drawing at time.
    while (MFrameIndexLock[MRenderFrameIndex].test_and_set());
    
    // if this frame is not null, it represent the queue is full and gpu draw work of this frame has not start.
    while (MFrameCircleQueue[MRenderFrameIndex] != nullptr)
    {
        MFrameIndexLock[MRenderFrameIndex].clear();
        std::this_thread::sleep_for(std::chrono::milliseconds(1));
    }
}

void CRHI::EndFrame()
{
    CHECK(MFrameCircleQueue[MRenderFrameIndex] != nullptr);
    MFrameIndexLock[MRenderFrameIndex].clear();
    if (!MFrameReady)
    {
        MFrameReady = true;
    }
}

void CRHI::SetCurrentFrame(CRHIFrame *Frame)
{
    MFrameCircleQueue[MRenderFrameIndex] = Frame;
}

CRHIFrame* CRHI::GetDrawFrame()
{
    // check render has started or not.
    while (!MFrameReady);
    
    // increase draw frame index first.
    MDrawFrameIndex = (MDrawFrameIndex + 1) % MAX_FRAME_BUFF_COUNT;
    
    // test this frame is been rendering at time.
    while (MFrameIndexLock[MDrawFrameIndex].test_and_set());
    
    // if this frame is null, it represent the queue is empty and render work of this frame has not start.
    while (MFrameCircleQueue[MDrawFrameIndex] == nullptr)
    {
        MFrameIndexLock[MDrawFrameIndex].clear();
        std::this_thread::sleep_for(std::chrono::milliseconds(1));
    }
    return MFrameCircleQueue[MDrawFrameIndex];
}

void CRHI::FinishDrawFrame()
{
    CHECK(MFrameCircleQueue[MDrawFrameIndex] != nullptr);
    MFrameCircleQueue[MDrawFrameIndex] = nullptr;
    MFrameIndexLock[MDrawFrameIndex].clear();
}

}
