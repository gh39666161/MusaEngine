#pragma once
#include "Core.h"
#include "Application.h"

ENGINE_BEGIN()
class FBaseApplication : public FApplication
{
public:
    FBaseApplication();
    int32 Initialize() override;
    void Finalize() override;
    void Update() override;
    bool IsQuit() override;
protected:
    bool MBQuit;
};
ENGINE_END()