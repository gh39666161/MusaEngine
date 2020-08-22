#pragma once
#include "Render/BaseRHI/Public/BaseRHI.h"

ENGINE_BEGIN()
class FOpenGLRHI : public FBaseRHI
{
public:
    FOpenGLRHI();
    virtual ~FOpenGLRHI();
    virtual int32 Initialize();
    virtual void Finalize();
    virtual void Update();
    bool InitializeShader(const char* vsFilename, const char* fsFilename);

private:
    unsigned int MVertexShader;
    unsigned int MFragmentShader;
    unsigned int MShaderProgram;
};
ENGINE_END()
