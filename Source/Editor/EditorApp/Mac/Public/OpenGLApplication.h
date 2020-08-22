#pragma once
#include "Core/Public/Core.h"
#include "Platform/Public/Application.h"

ENGINE_BEGIN()
class FOpenGLApplication : public FApplication {
public:
    FOpenGLApplication();
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

ENGINE_END()