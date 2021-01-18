#include <metal_stdlib>
using namespace metal;

#include "common.h"

fragment float4 MainPS(ColorInOut in [[stage_in]]) {
    return float4(1.0,0,0,1);
}
