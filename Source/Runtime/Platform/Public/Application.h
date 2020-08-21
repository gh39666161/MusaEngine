#pragma once
#include "Core/Public/Core.h"
#include "Core/Public/RuntimeModule.h"

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
