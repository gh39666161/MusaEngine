#pragma once
#include "Core/Public/Core.h"
#include "Platform/Public/Application.h"

namespace MusaEngine
{
    class CMetalApplication : public CApplication {
    public:
        CMetalApplication();
        int32 Initialize() override;
        void Finalize() override;
        // One cycle of the main loop
        void Update() override;
    };
}
