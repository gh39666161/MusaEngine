#pragma once
#include <string>
#import <OpenGL/gl.h>
#include "Core/Public/RuntimeModule.hpp"
ENGINE_BEGIN()

class FOpenglRHI : public FRuntimeModule
{
public:
    FOpenglRHI();
    virtual ~FOpenglRHI();
    int32 Initialize() override;
    void Finalize() override;
    void Update() override;
    uint32 CompileShader(const std::string& Vertext, const std::string& Fragment);
    void Draw(uint32 shader);
private:
};
ENGINE_END()
