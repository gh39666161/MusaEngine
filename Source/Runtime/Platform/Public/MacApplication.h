#pragma once
#include "Core.h"
#include "Application.h"

ENGINE_BEGIN()
class FMacApplication : public FApplication {
public:
    FMacApplication();
    int32 Initialize() override;
    void Finalize() override;
    // One cycle of the main loop
    void Update() override;

    //void* GetMainWindowHandler() override;

protected:
    void CreateMainWindow();

protected:
    NSWindow* MPWindow;
};

FMacApplication GMacApp;
FApplication* GPApp = &GMacApp;
ENGINE_END()
