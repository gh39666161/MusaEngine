//
//  MetalRenderer.mm
//  MusaEngine
//
//  Created by musa on 2020/12/18.
//  Copyright © 2020 musa. All rights reserved.
//

#import "Render/MetalRHI/Public/MetalRenderer.h"
using namespace MusaEngine;

static const NSUInteger kMaxBuffersInFlight = 3;

//static const size_t kAlignedUniformsSize = (sizeof(Uniforms) & ~0xFF) + 0x100;

@implementation MetalRenderer
{
    dispatch_semaphore_t _inFlightSemaphore;
    id <MTLDevice> _device;
    id <MTLCommandQueue> _commandQueue;
    id <MTLCommandBuffer> _commandBuffer;
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
    if (shaderIndex == IDX_NONE)
    {
        return nil;
    }
    if ([_shaders count] <= shaderIndex)
    {
        return nil;
    }
    return _shaders[shaderIndex];
}

- (void)drawInMTKView:(nonnull MTKView *)view
{
    /// Per frame updates here
    dispatch_semaphore_wait(_inFlightSemaphore, DISPATCH_TIME_FOREVER);
    id <MTLCommandBuffer> commandBuffer = [_commandQueue commandBuffer];
    commandBuffer.label = @"MyCommand";

    __block dispatch_semaphore_t block_sema = _inFlightSemaphore;
    [commandBuffer addCompletedHandler:^(id<MTLCommandBuffer> buffer)
     {
         dispatch_semaphore_signal(block_sema);
     }];
    [commandBuffer enqueue];
    
    auto frame = GDMODULE(CRHI)->GetDrawFrame();
    for (CRHIPass* rhiPass: frame->GetPassList())
    {
        [self drawPass:rhiPass withCommandBuffer:commandBuffer];
    }
    GDMODULE(CRHI)->FinishDrawFrame();
    
    [commandBuffer presentDrawable:view.currentDrawable];
    [commandBuffer commit];
}


- (void)dealloc
{
    [_inFlightSemaphore release];
    [_mtkView release];
    [_commandQueue release];
    [_shaders release];
    [super dealloc];
}

//- (void) drawPass:(nonnull CRHICommand*) rhiCommand withCommandBuffer:(id<MTLCommandBuffer>) commandBuffer
//{
//    id<MTLFunction> vertexFunction = [self getShader:rhiCommand->GetVertexShader()];
//    id<MTLFunction> fragmentFunction = [self getShader:rhiCommand->GetFragmentShader()];
//    if (vertexFunction == nil || fragmentFunction == nil)
//    {
//        return;
//    }
//
//    CRHIVertexFactory* rhiVertexFactory = rhiCommand->GetVertexFactory();
//    CBuffer* rhiVertexBuffer = rhiVertexFactory->GetVertexBuffer();
//    CBuffer* rhiIndiceBuffer = rhiVertexFactory->GetIndiceBuffer();
//    uint32 rhiIndiceCount = rhiVertexFactory->GetIndiceCount();
//
//    MTLRenderPassDescriptor* renderPassDes = _mtkView.currentRenderPassDescriptor;
//    renderPassDes.colorAttachments[0].texture = [_mtkView.currentDrawable texture];
//    renderPassDes.colorAttachments[0].loadAction = MTLLoadActionClear;
//    renderPassDes.colorAttachments[0].clearColor = MTLClearColorMake(1.0, 1.0, 1.0, 1.0);
//
//    id<MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDes];
//    renderEncoder.label = @"Draw";
//
//    MTLRenderPipelineDescriptor* descriptor = [[MTLRenderPipelineDescriptor alloc] init];
//    descriptor.vertexFunction = vertexFunction;
//    descriptor.fragmentFunction = fragmentFunction;
//    descriptor.colorAttachments[0].pixelFormat = MTLPixelFormatBGRA8Unorm;
//    id<MTLRenderPipelineState> pipelineState = [_device newRenderPipelineStateWithDescriptor:descriptor error:nil];
//    [descriptor release];
//    [renderEncoder setRenderPipelineState:pipelineState];
//    [pipelineState release];
//
//    id<MTLBuffer> VertexBuffer = [_device newBufferWithBytes:rhiVertexBuffer->GetData() length:rhiVertexBuffer->GetSize() options:MTLResourceCPUCacheModeDefaultCache];
//    [renderEncoder setVertexBuffer:VertexBuffer offset:0 atIndex:0];
//    [VertexBuffer release];
//
//    id<MTLBuffer> indexBuffer = [_device newBufferWithBytes:rhiIndiceBuffer->GetData() length:rhiIndiceBuffer->GetSize() options:MTLResourceStorageModeShared];
//    [renderEncoder drawIndexedPrimitives:MTLPrimitiveTypeTriangle
//           indexCount:rhiIndiceCount
//            indexType:MTLIndexTypeUInt32
//          indexBuffer:indexBuffer
//    indexBufferOffset:0];
//    [indexBuffer release];
//
//    [renderEncoder endEncoding];
    
//}

- (void) drawPass:(nonnull CRHIPass*) rhiPass withCommandBuffer:(id<MTLCommandBuffer>) commandBuffer
{
    MTLRenderPassDescriptor* renderPassDes = _mtkView.currentRenderPassDescriptor;
    renderPassDes.colorAttachments[0].texture = [_mtkView.currentDrawable texture];
    renderPassDes.colorAttachments[0].loadAction = MTLLoadActionClear;
    renderPassDes.colorAttachments[0].clearColor = MTLClearColorMake(1.0, 1.0, 1.0, 1.0);

    id<MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDes];
    renderEncoder.label = @"Draw";
    for (CRHIPSO* rhiPSO: rhiPass->GetPSOList())
    {
        [self drawPSO:rhiPSO withRenderEncoder:renderEncoder];
    }
    
    [renderEncoder endEncoding];
}

- (void)drawPSO:(nonnull MusaEngine::CRHIPSO*) rhiPSO withRenderEncoder:(id<MTLRenderCommandEncoder>_Nonnull) renderEncoder
{
    id<MTLFunction> vertexFunction = [self getShader:rhiPSO->GetVertexShader()];
    id<MTLFunction> fragmentFunction = [self getShader:rhiPSO->GetFragmentShader()];
    if (vertexFunction == nil || fragmentFunction == nil)
    {
        return;
    }
    
    CRHIVertexFactory* rhiVertexFactory = rhiPSO->GetVertexFactory();
    CBuffer* rhiVertexBuffer = rhiVertexFactory->GetVertexBuffer();
    CBuffer* rhiIndiceBuffer = rhiVertexFactory->GetIndiceBuffer();
    uint32 rhiIndiceCount = rhiVertexFactory->GetIndiceCount();
    
    MTLRenderPipelineDescriptor* descriptor = [[MTLRenderPipelineDescriptor alloc] init];
    descriptor.vertexFunction = vertexFunction;
    descriptor.fragmentFunction = fragmentFunction;
    descriptor.colorAttachments[0].pixelFormat = MTLPixelFormatBGRA8Unorm;
    id<MTLRenderPipelineState> pipelineState = [_device newRenderPipelineStateWithDescriptor:descriptor error:nil];
    [descriptor release];
    [renderEncoder setRenderPipelineState:pipelineState];
    [pipelineState release];
    
    id<MTLBuffer> VertexBuffer = [_device newBufferWithBytes:rhiVertexBuffer->GetData() length:rhiVertexBuffer->GetSize() options:MTLResourceCPUCacheModeDefaultCache];
    [renderEncoder setVertexBuffer:VertexBuffer offset:0 atIndex:0];
    [VertexBuffer release];

    id<MTLBuffer> indexBuffer = [_device newBufferWithBytes:rhiIndiceBuffer->GetData() length:rhiIndiceBuffer->GetSize() options:MTLResourceStorageModeShared];
    [renderEncoder drawIndexedPrimitives:MTLPrimitiveTypeTriangle
           indexCount:rhiIndiceCount
            indexType:MTLIndexTypeUInt32
          indexBuffer:indexBuffer
    indexBufferOffset:0];
    [indexBuffer release];
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
