#pragma once
#include "Core.h"
#include "RuntimeModule.h"

ENGINE_BEGIN()
class FApplication : public FRuntimeModule
{
public:
    FApplication();
    virtual int32 Initialize();
    virtual void Finalize();
    virtual void Update();
    virtual bool IsQuit();
protected:
    bool MBQuit;
};
ENGINE_END()
