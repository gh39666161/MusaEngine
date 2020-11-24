#pragma once
#include <string>
#include "Render/RHI/Public/RHIDefines.h"
#include "Render/MetalRHI/Public/MetalRHI.h"
#include "Core/Public/RuntimeModule.hpp"

namespace MusaEngine
{
    class CRHI : public CRuntimeModule
    {
    public:
        CRHI();
        virtual ~CRHI();
        int32 Initialize() override;
        void Finalize() override;
        void Update() override;
        uint32 CompileShader(const std::string& File, RHIShaderType CompileShaderType);
    private:
        bool MUseOpengl;
        uint32 MVertexShader;
        uint32 MFragmentShader;
    };
}
