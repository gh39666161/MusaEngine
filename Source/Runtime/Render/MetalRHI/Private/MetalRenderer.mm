#import "Render/MetalRHI/Public/MetalRHI.h"
#import "Render/MetalRHI/Public/MetalRenderer.h"
USE_ENGINE()

@implementation MetalRenderer
{
    
}

- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView*) mtkView
                                      device:(id<MTLDevice>) device
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    GMODULE(FMetalRHI)->SetMetalRenderer(self);
    _shaders = [[NSMutableArray<id<MTLFunction>> alloc] init];
    _mtkView = mtkView;
    _device = device;
    
    _commandQueue = [_device newCommandQueue];
    return self;
}

- (uint32_t)compileVertexShader:(nonnull NSString*) source
{
    NSError *error = nil;
//        NSString* NsSource = [NSString stringWithCString:Source.c_str() encoding:[NSString defaultCStringEncoding]];
    id<MTLLibrary> Library = [_device newLibraryWithSource: source options: nil error:&error];
    if (Library == nullptr)
    {
        NSLog(@"Library error: %@", error);
    }

    id<MTLFunction> Function = [Library newFunctionWithName:@"MainVS"];
    [_shaders addObject:Function];
    return [_shaders count] - 1;
}

- (NSUInteger)compileShader:(nonnull NSString*) source functionName: (nonnull NSString*) name;
{
    NSError *error = nil;
//        NSString* NsSource = [NSString stringWithCString:Source.c_str() encoding:[NSString defaultCStringEncoding]];
    id<MTLLibrary> Library = [_device newLibraryWithSource: source options: nil error:&error];
    if (Library == nullptr)
    {
        NSLog(@"Library error: %@", error);
    }

    id<MTLFunction> Function = [Library newFunctionWithName:name];
    [_shaders addObject:Function];
    return [_shaders count] - 1;
}

- (id<MTLFunction>) getShader:(NSUInteger) shaderIndex
{
    if ([_shaders count] <= shaderIndex)
    {
        return nil;
    }
    return _shaders[shaderIndex];
}

- (void) drawDebug:(NSUInteger) vertexShaderIndex Fragment:(NSUInteger) fragmentShaderIndex
{
    id<MTLFunction> vertexFunction = [self getShader:vertexShaderIndex];
    id<MTLFunction> fragmentFunction = [self getShader:fragmentShaderIndex];
    if (vertexFunction == nil || fragmentFunction == nil)
    {
        return;
    }

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

    id<MTLCommandBuffer> CommandBuffer = [_commandQueue commandBuffer];

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

    [CommandBuffer presentDrawable:static_cast<id<MTLDrawable>>(_mtkView.currentDrawable)];
    [CommandBuffer commit];
}

@end
