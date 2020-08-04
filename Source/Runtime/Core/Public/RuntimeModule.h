#pragma once
#include "Core.h"

ENGINE_BEGIN()
class FRuntimeModule
{
public:
    virtual ~FRuntimeModule() {};
    virtual int32 Initialize() = 0;
    virtual void Finalize() = 0;
    virtual void Update() = 0;  
};
ENGINE_END()