#pragma once
#include "Core/Public/FastRecycle.h"

ENGINE_BEGIN()
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
ENGINE_END()
