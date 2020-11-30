#import "Render/RHI/Public/RHI.h"
#import "Render/MetalRHI/Public/MetalRHI.h"
#import "Render/MetalRHI/Public/MetalRenderer.h"
using namespace MusaEngine;

@implementation MetalRenderer
{
    dispatch_semaphore_t sg;
}

- (void) dealloc
{
    [_mtkView release];
    [_device release];
    [_commandQueue release];
    [_shaders release];
    [super dealloc];
}

- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView*) mtkView
                                      device:(id<MTLDevice>) device
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    GMODULE(CMetalRHI)->SetMetalRenderer(self);
    _shaders = [[NSMutableArray<id<MTLFunction>> alloc] init];
    _mtkView = mtkView;
    _device = device;
    
    _commandQueue = [_device newCommandQueue];
    sg = dispatch_semaphore_create(1);
    return self;
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

- (void) drawFrame
{
    [_mtkView setNeedsDisplay:YES];
}

- (void) draw
{
    auto frame = GDMODULE(CRHI)->GetFrame();
    
    //dispatch_semaphore_wait(sg, DISPATCH_TIME_FOREVER);
    id<MTLFunction> vertexFunction = [self getShader:frame->MVertexShader];
    id<MTLFunction> fragmentFunction = [self getShader:frame->MFragmentShader];
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
    CommandBuffer.label = @"Debug Command Buffer";
    [CommandBuffer enqueue];

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
    
    [CommandBuffer presentDrawable:_mtkView.currentDrawable];
    
    __block dispatch_semaphore_t block_sema = sg;
    [CommandBuffer addCompletedHandler:^(id<MTLCommandBuffer> buffer) {
        //dispatch_semaphore_signal(block_sema);
    }];
    
    [CommandBuffer commit];
}

@end
