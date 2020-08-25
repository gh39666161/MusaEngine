#include <iostream>
#include <fstream>
#import <OpenGL/gl3.h>
#import <OpenGL/glu.h>
#include "Render/RHI/Public/RHI.h"
#include "Render/OpenglRHI/Public/OpenglDevice.h"

ENGINE_BEGIN()

enum {
    ATTRIB_VERTEX,
    ATTRIB_COLOR,
     
    NUM_ATTRIBUTES
};

OpenglDevice::OpenglDevice()
{
    
}

OpenglDevice::~OpenglDevice()
{

}

void OpenglDevice::Initialize()
{
//    MContext = Context;
//    int result = gladLoadGL();
//    if (!result) {
////        cerr << "OpenGL load failed!" << endl;
//        result = -1;
//    } else {
//        result = 0;
////        cout << "OpenGL Version " << GLVersion.major << "." << GLVersion.minor << " loaded" << endl;
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
    //return 0;
}

uint32 OpenglDevice::CompileShader(const std::string& Vertext, const std::string& Fragment)
{
    int status;
    // Create a vertex and fragment shader object.
    unsigned int VertexShader = glCreateShader(GL_VERTEX_SHADER);
    unsigned int FragmentShader = glCreateShader(GL_FRAGMENT_SHADER);

    // Copy the shader source code strings into the vertex and fragment shader objects.
    const char* _v_c_str =  Vertext.c_str();
    glShaderSource(VertexShader, 1, &_v_c_str, NULL);
    const char* _f_c_str =  Fragment.c_str();
    glShaderSource(FragmentShader, 1, &_f_c_str, NULL);

    // Compile the shaders.
    glCompileShader(VertexShader);
    glCompileShader(FragmentShader);

    // Check to see if the vertex shader compiled successfully.
    glGetShaderiv(VertexShader, GL_COMPILE_STATUS, &status);
    if(status != 1)
    {
            // If it did not compile then write the syntax error message out to a text file for review.
            //OutputShaderErrorMessage(MVertexShader, vsFilename);
            return false;
    }

    // Check to see if the fragment shader compiled successfully.
    glGetShaderiv(FragmentShader, GL_COMPILE_STATUS, &status);
    if(status != 1)
    {
            // If it did not compile then write the syntax error message out to a text file for review.
            //OutputShaderErrorMessage(MFragmentShader, fsFilename);
            return false;
    }

    // Create a shader program object.
    unsigned int ShaderProgram = glCreateProgram();

    // Attach the vertex and fragment shader to the program object.
    glAttachShader(ShaderProgram, VertexShader);
    glAttachShader(ShaderProgram, FragmentShader);

    // Bind the shader input variables.
    glBindAttribLocation(ShaderProgram, ATTRIB_VERTEX, "inputPosition");
    glBindAttribLocation(ShaderProgram, ATTRIB_COLOR, "inputColor");

    // Link the shader program.
    glLinkProgram(ShaderProgram);

    // Check the status of the link.
    glGetProgramiv(ShaderProgram, GL_LINK_STATUS, &status);
    if(status != 1)
    {
        // If it did not link then write the syntax error message out to a text file for review.
        //OutputLinkerErrorMessage(MShaderProgram);
        return 0;
    }

    return ShaderProgram;
}

OpenglDevice* OpenglDevice::Get()
{
    static OpenglDevice* OpenglDeviceInst = new OpenglDevice();
    return OpenglDeviceInst;
}

void OpenglDevice::Draw(uint32 shader)
{
    glUseProgram(shader);
    static const GLfloat squareVertices[] = {
           -1.0f, -1.0f, 0.0f,
           1.0f, -1.0f, 0.0f,
           -1.0f,  1.0f, 0.0f,
           1.0f,  1.0f, 0.0f
       };
    static const GLfloat squareColors[] = {
        1.0f, 0.0f, 0.0f,
        1.0f, 1.0f, 0.0f,
        0.0f,  1.0f, 0.0f,
        0.0f,  1.0f, 1.0f
    };
    glVertexAttribPointer(ATTRIB_VERTEX, 3, GL_FLOAT, 0, 0, squareVertices);
    glEnableVertexAttribArray(ATTRIB_VERTEX);
    glVertexAttribPointer(ATTRIB_COLOR, 3, GL_FLOAT, 0, 0, squareColors);
    glEnableVertexAttribArray(ATTRIB_COLOR);
    glEnable(GL_CULL_FACE);
    glFlush();
}

ENGINE_END()
