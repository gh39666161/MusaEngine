#pragma once
#include "Core/Public/Core.h"

namespace MusaEngine
{

struct Vec2
{
public:
    float X;
    float Y;
};

struct Vec3
{
public:
    float X;
    float Y;
    float Z;
    static const Vec3 Zero;
public:
    Vec3(float InX, float InY, float InZ): X(InX), Y(InY), Z(InZ) {}
    Vec3(const Vec3& From);
};

struct Vec4
{
public:
    float X;
    float Y;
    float Z;
    float W;
    static const Vec4 Zero;
public:
    Vec4(float InX, float InY, float InZ, float InW): X(InX), Y(InY), Z(InZ), W(InW) {}
    Vec4(const Vec4& From);
};

}
