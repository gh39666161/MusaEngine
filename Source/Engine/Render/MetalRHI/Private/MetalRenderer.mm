//
//  MetalRenderer.mm
//  MusaEngine
//
//  Created by musa on 2020/12/18.
//  Copyright © 2020 musa. All rights reserved.
//

#import "Render/MetalRHI/Public/MetalRHI.h"
#import "Render/MetalRHI/Public/MetalRenderer.h"
using namespace MusaEngine;

static const NSUInteger kMaxBuffersInFlight = 3;

//static const size_t kAlignedUniformsSize = (sizeof(Uniforms) & ~0xFF) + 0x100;

@implementation MetalRenderer
{
    dispatch_semaphore_t _inFlightSemaphore;
    id <MTLDevice> _device;
    id <MTLCommandQueue> _commandQueue;
    NSMutableArray<id<MTLFunction>>* _shaders;
    MTKView* _mtkView;
}

-(nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)view;
{
    self = [super init];
    if(self)
    {
        _mtkView = view;
        _device = view.device;
        
        _inFlightSemaphore = dispatch_semaphore_create(kMaxBuffersInFlight);
        _shaders = [[NSMutableArray<id<MTLFunction>> alloc] init];
        _commandQueue = [_device newCommandQueue];
    }
    return self;
}

- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size
{
    /// Respond to drawable size or orientation changes here

//    float aspect = size.width / (float)size.height;
//    _projectionMatrix = matrix_perspective_right_hand(65.0f * (M_PI / 180.0f), aspect, 0.1f, 100.0f);
}

- (void)drawInMTKView:(nonnull MTKView *)view
{
    /// Per frame updates here
    dispatch_semaphore_wait(_inFlightSemaphore, DISPATCH_TIME_FOREVER);
    
    auto frame = GDMODULE(CRHI)->GetFrame();
    if (!frame->MIsOk) {
        return;
    }
    
    id<MTLFunction> vertexFunction = [self getShader:frame->MVertexShader];
    id<MTLFunction> fragmentFunction = [self getShader:frame->MFragmentShader];
    if (vertexFunction == nil || fragmentFunction == nil)
    {
        return;
    }

    id <MTLCommandBuffer> CommandBuffer = [_commandQueue commandBuffer];
    CommandBuffer.label = @"MyCommand";

    __block dispatch_semaphore_t block_sema = _inFlightSemaphore;
    [CommandBuffer addCompletedHandler:^(id<MTLCommandBuffer> buffer)
     {
         dispatch_semaphore_signal(block_sema);
     }];
    [CommandBuffer enqueue];

    MTLRenderPipelineDescriptor* Descriptor = [[MTLRenderPipelineDescriptor alloc] init];
    Descriptor.vertexFunction = vertexFunction;
    Descriptor.fragmentFunction = fragmentFunction;
    Descriptor.colorAttachments[0].pixelFormat = MTLPixelFormatBGRA8Unorm;

    id<MTLRenderPipelineState> PipelineState = [_device newRenderPipelineStateWithDescriptor:Descriptor error:nil];
    [Descriptor release];

    float VertexArray[] = {
        1.0f,  1.0f, 0.0f,
        -1.0f, -1.0f, 0.0f,
        1.0f, -1.0f, 0.0f
    };
    id<MTLBuffer> VertexBuffer = [_device newBufferWithBytes:VertexArray length:sizeof(VertexArray) options:MTLResourceCPUCacheModeDefaultCache];


    MTLRenderPassDescriptor* RenderPassDes = [[MTLRenderPassDescriptor alloc] init];
    RenderPassDes.colorAttachments[0].texture = [_mtkView.currentDrawable texture];
    RenderPassDes.colorAttachments[0].loadAction = MTLLoadActionClear;
    RenderPassDes.colorAttachments[0].clearColor = MTLClearColorMake(1.0, 1.0, 1.0, 1.0);

    id<MTLRenderCommandEncoder> RenderEncoder = [CommandBuffer renderCommandEncoderWithDescriptor:RenderPassDes];
    [RenderPassDes release];

    [RenderEncoder setRenderPipelineState:PipelineState];
    [RenderEncoder setVertexBuffer:VertexBuffer offset:0 atIndex:0];
    RenderEncoder.label = @"Draw";
    [PipelineState release];
    [VertexBuffer release];

    [RenderEncoder drawPrimitives:MTLPrimitiveTypeTriangleStrip vertexStart:0 vertexCount:3];
    [RenderEncoder endEncoding];
    
    [CommandBuffer presentDrawable:view.currentDrawable];
    
    [CommandBuffer commit];
}

- (NSInteger)compileShader:(nonnull NSString*) source functionName: (nonnull NSString*) name;
{
    NSError *error = nil;
//        NSString* NsSource = [NSString stringWithCString:Source.c_str() encoding:[NSString defaultCStringEncoding]];
    id<MTLLibrary> library = [_device newLibraryWithSource: source options: nil error:&error];
    if (library == nullptr)
    {
        NSLog(@"Library error: %@", error);
    }

    id<MTLFunction> function = [library newFunctionWithName:name];
    [library release];
    
    if (function != nil)
    {
        [_shaders addObject:function];
        [function release];
        
        return [_shaders count] - 1;
    }
    return IDX_NONE;
}

- (id<MTLFunction>) getShader:(NSInteger) shaderIndex
{
    if ([_shaders count] <= shaderIndex)
    {
        return nil;
    }
    return _shaders[shaderIndex];
}

- (void)dealloc
{
    [_inFlightSemaphore release];
    [_mtkView release];
    [_commandQueue release];
    [_shaders release];
    [super dealloc];
}

//- (void)_updateDynamicBufferState
//{
//    /// Update the state of our uniform buffers before rendering
//
//    _uniformBufferIndex = (_uniformBufferIndex + 1) % kMaxBuffersInFlight;
//
//    _uniformBufferOffset = kAlignedUniformsSize * _uniformBufferIndex;
//
//    _uniformBufferAddress = ((uint8_t*)_dynamicUniformBuffer.contents) + _uniformBufferOffset;
//}
//
//- (void)_updateGameState
//{
//    /// Update any game state before encoding renderint commands to our drawable
//
//    Uniforms * uniforms = (Uniforms*)_uniformBufferAddress;
//
//    uniforms->projectionMatrix = _projectionMatrix;
//
//    vector_float3 rotationAxis = {1, 1, 0};
//    matrix_float4x4 modelMatrix = matrix4x4_rotation(_rotation, rotationAxis);
//    matrix_float4x4 viewMatrix = matrix4x4_translation(0.0, 0.0, -8.0);
//
//    uniforms->modelViewMatrix = matrix_multiply(viewMatrix, modelMatrix);
//
//    _rotation += .01;
//}

//#pragma mark Matrix Math Utilities
//
//matrix_float4x4 matrix4x4_translation(float tx, float ty, float tz)
//{
//    return (matrix_float4x4) {{
//        { 1,   0,  0,  0 },
//        { 0,   1,  0,  0 },
//        { 0,   0,  1,  0 },
//        { tx, ty, tz,  1 }
//    }};
//}
//
//static matrix_float4x4 matrix4x4_rotation(float radians, vector_float3 axis)
//{
//    axis = vector_normalize(axis);
//    float ct = cosf(radians);
//    float st = sinf(radians);
//    float ci = 1 - ct;
//    float x = axis.x, y = axis.y, z = axis.z;
//
//    return (matrix_float4x4) {{
//        { ct + x * x * ci,     y * x * ci + z * st, z * x * ci - y * st, 0},
//        { x * y * ci - z * st,     ct + y * y * ci, z * y * ci + x * st, 0},
//        { x * z * ci + y * st, y * z * ci - x * st,     ct + z * z * ci, 0},
//        {                   0,                   0,                   0, 1}
//    }};
//}
//
//matrix_float4x4 matrix_perspective_right_hand(float fovyRadians, float aspect, float nearZ, float farZ)
//{
//    float ys = 1 / tanf(fovyRadians * 0.5);
//    float xs = ys / aspect;
//    float zs = farZ / (nearZ - farZ);
//
//    return (matrix_float4x4) {{
//        { xs,   0,          0,  0 },
//        {  0,  ys,          0,  0 },
//        {  0,   0,         zs, -1 },
//        {  0,   0, nearZ * zs,  0 }
//    }};
//}

@end
