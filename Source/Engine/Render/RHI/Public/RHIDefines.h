#pragma once
#include "Core/Public/Vector.h"

namespace MusaEngine
{

enum RHIShaderType
{
    Vertex,
    Fragment
};

const int32 MAX_FRAME_BUFF_COUNT = 5;

struct RHIVertex
{
public:
    Vec4 Pos;
public:
    RHIVertex(): Pos(Vec4::Zero) {}
};

}
