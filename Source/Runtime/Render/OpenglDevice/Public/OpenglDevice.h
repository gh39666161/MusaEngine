#pragma once
#include <string>
#import <OpenGL/gl.h>
#include "Core/Public/Core.h"
ENGINE_BEGIN()

class OpenglDevice
{
public:
    OpenglDevice();
    ~OpenglDevice();
    void Initialize();
    uint32 CompileShader(const std::string& Vertext, const std::string& Fragment);
    static OpenglDevice* Get();
    void Draw(uint32 shader);
private:
};
ENGINE_END()
