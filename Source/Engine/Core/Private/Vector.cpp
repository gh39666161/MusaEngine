#include "Core/Public/Vector.h"
namespace MusaEngine
{

const Vec3 Vec3::Zero = Vec3(0.0f, 0.0f, 0.0f);
Vec3::Vec3(const Vec3& From)
{
    X = From.X;
    Y = From.Y;
    Z = From.Z;
}

const Vec4 Vec4::Zero = Vec4(0.0f, 0.0f, 0.0f, 0.0f);
Vec4::Vec4(const Vec4& From)
{
    X = From.X;
    Y = From.Y;
    Z = From.Z;
    W = From.W;
}

}
