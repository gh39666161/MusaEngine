#pragma once
#include <cstdio>
#include <string>
#include <utility>
#include <vector>
#include "Core/Public/FastRecycle.h"

namespace MusaEngine
{
    class FBuffer : public FastRecycle
    {
    public:
        FBuffer();
        FBuffer(uint64 Size);
        FBuffer(const FBuffer& Other);
        virtual ~FBuffer();
        uint8* GetData();
        uint64 GetSize();
    private:
        uint8* MData;
        uint64 MSize;
    };
}
