#include "Common/Public/Buffer.h"

namespace MusaEngine
{
    extern "C" void* malloc(size_t size);
    extern "C" void  free(void* p);

    CBuffer::CBuffer():
    MData(nullptr),
    MSize(0)
    {
        
    }

    CBuffer::CBuffer(uint64 Size):
    MSize(Size)
    {
        MData = reinterpret_cast<uint8*>(malloc(Size));
    }

    CBuffer::CBuffer(const CBuffer& Other)
    {
        MData = reinterpret_cast<uint8*>(malloc(Other.MSize));
        memcpy(MData, Other.MData, Other.MSize);
        MSize = Other.MSize;
    }

    CBuffer::~CBuffer()
    {
        if (MData)
        {
            free(MData);
        }
        MData = nullptr;
        MData = 0;
    }

    uint8* CBuffer::GetData()
    {
        return MData;
    }
    uint64 CBuffer::GetSize()
    {
        return MSize;
    }
}
