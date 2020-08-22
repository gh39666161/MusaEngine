#pragma once
#include "Core/Public/Core.h"
#include "Core/Public/RuntimeModule.h"

ENGINE_BEGIN()
class FBaseRHI : public FRuntimeModule
{
public:
    FBaseRHI();
    virtual ~FBaseRHI();
    virtual int32 Initialize();
    virtual void Finalize();
    virtual void Update();
};
ENGINE_END()
