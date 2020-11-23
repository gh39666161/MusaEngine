#pragma once
#include "Core/Public/Core.h"
#include "Platform/Public/Application.h"

namespace MusaEngine
{
    class FMetalApplication : public FApplication {
    public:
        FMetalApplication();
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
}
