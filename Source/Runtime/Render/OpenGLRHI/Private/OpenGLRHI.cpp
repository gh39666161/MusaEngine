#include <iostream>
#include <fstream>
//#include "glad/glad.h"
#include "Render/OpenGLRHI/Public/OpenGLRHI.h"

ENGINE_BEGIN()
FOpenGLRHI::FOpenGLRHI()
{

}

FOpenGLRHI::~FOpenGLRHI()
{

}

int32 FOpenGLRHI::Initialize()
{
//    int result = gladLoadGL();
//    if (!result) {
//        cerr << "OpenGL load failed!" << endl;
//        result = -1;
//    } else {
//        result = 0;
//        cout << "OpenGL Version " << GLVersion.major << "." << GLVersion.minor << " loaded" << endl;
//
//        if (GLAD_GL_VERSION_3_0) {
//            // Set the depth buffer to be entirely cleared to 1.0 values.
//            glClearDepth(1.0f);
//
//            // Enable depth testing.
//            glEnable(GL_DEPTH_TEST);
//
//            // Set the polygon winding to front facing for the left handed system.
//            glFrontFace(GL_CW);
//
//            // Enable back face culling.
//            glEnable(GL_CULL_FACE);
//            glCullFace(GL_BACK);
//        }
//
//        InitializeShader(VS_SHADER_SOURCE_FILE, PS_SHADER_SOURCE_FILE);
//    }
//
//    return result;
    return 0;
}
void FOpenGLRHI::Finalize()
{

}
void FOpenGLRHI::Update()
{

}

bool FOpenGLRHI::InitializeShader(const char* vsFilename, const char* fsFilename)
{
    return true;
}

ENGINE_END()
