#pragma once
#include <cstdio>
#include <string>
#include <utility>
#include <vector>
#include "Core/Public/FastRecycle.h"

namespace MusaEngine
{
class CBuffer : public CFastRecycle
{
public:
    CBuffer();
    CBuffer(uint64 Size);
    CBuffer(const CBuffer& Other);
    virtual ~CBuffer();
    uint8* GetData();
    uint64 GetSize();
private:
    uint8* MData;
    uint64 MSize;
};
}
