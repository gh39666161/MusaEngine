#pragma once
#include "Core.h"
#include "RuntimeModule.h"

ENGINE_BEGIN()
class FApplication : public FRuntimeModule
{
public:
    virtual int32 Initialize() = 0;
    virtual void Finalize() = 0;
    virtual void Update() = 0;
    virtual bool IsQuit() = 0;
};
ENGINE_END()