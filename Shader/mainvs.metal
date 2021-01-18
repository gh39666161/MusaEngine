#include <metal_stdlib>
using namespace metal;

typedef struct
{
    float4 position [[position]];
    float2 texCoord;
} ColorInOut;

typedef struct
{
    vector_float4 pos;
} Vertex;

vertex ColorInOut MainVS(constant Vertex* in [[buffer(0)]], unsigned int vid[[vertex_id]])
{
    ColorInOut out;
    out.position = in[vid].pos;
    return out;
}

fragment float4 MainPS(ColorInOut in [[stage_in]])
{
    return float4(1.0,0,0,1);
}
