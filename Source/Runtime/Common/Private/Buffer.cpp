#include "Common/Public/Buffer.h"

namespace MusaEngine
{
    extern "C" void* malloc(size_t size);
    extern "C" void  free(void* p);

    FBuffer::FBuffer():
    MData(nullptr),
    MSize(0)
    {
        
    }

    FBuffer::FBuffer(uint64 Size):
    MSize(Size)
    {
        MData = reinterpret_cast<uint8*>(malloc(Size));
    }

    FBuffer::FBuffer(const FBuffer& Other)
    {
        MData = reinterpret_cast<uint8*>(malloc(Other.MSize));
        memcpy(MData, Other.MData, Other.MSize);
        MSize = Other.MSize;
    }

    FBuffer::~FBuffer()
    {
        if (MData)
        {
            free(MData);
        }
        MData = nullptr;
        MSize = 0;
    }

    uint8* FBuffer::GetData()
    {
        return MData;
    }
    uint64 FBuffer::GetSize()
    {
        return MSize;
    }
}
