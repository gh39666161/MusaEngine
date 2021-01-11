#pragma once
#include <string>
//#import <OpenGL/gl.h>
#include "Render/RHI/Public/RHI.h"

namespace MusaEngine
{
    class COpenglRHI : public CRHI
    {
    public:
        COpenglRHI();
        virtual ~COpenglRHI();
        int32 Initialize() override;
        void Finalize() override;
        void Update() override;
        int32 CompileShader(const std::string& Vertext, const std::string& Fragment);
        void Draw(uint32 shader);
    };
}
