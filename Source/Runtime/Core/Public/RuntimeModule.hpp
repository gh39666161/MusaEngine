#pragma once
#include "Core/Public/FastRecycle.h"

namespace MusaEngine
{
    class FRuntimeModule : public FastRecycle
    {
        
    public:
        virtual ~FRuntimeModule() {};
        virtual int32 Initialize() = 0;
        virtual void Finalize() = 0;
        virtual void Update() = 0;
        template <typename T>
        static T* GetModule()
        {
            static T* Module = new T;
            return Module;
        }
    };
}
