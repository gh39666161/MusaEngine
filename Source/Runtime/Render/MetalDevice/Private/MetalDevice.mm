#import "EditorApp/Mac/Public/MetalView.h"
#include "Render/MetalDevice/Public/MetalDevice.h"

ENGINE_BEGIN()

//enum {
//    ATTRIB_VERTEX,
//    ATTRIB_COLOR,
//
//    NUM_ATTRIBUTES
//};

MetalDevice::MetalDevice()
{
    
}

MetalDevice::~MetalDevice()
{

}

void MetalDevice::Initialize(MetalView* View)
{
    MMetalView = View;
}

uint32 MetalDevice::CompileShader(const std::string& Source,  ShaderType CompileShaderType)
{
    NSError *error = nil;
    NSString* NsSource = [NSString stringWithCString:Source.c_str() encoding:[NSString defaultCStringEncoding]];
    id<MTLLibrary> Library = [MMetalView.device newLibraryWithSource: NsSource options: nil error:&error];
    if (Library == nullptr)
    {
        NSLog(@"Library error: %@", error);
    }
    NSString* FunctionName = @"";
    if (CompileShaderType == ShaderType::Vertex)
    {
        FunctionName = @"MainVS";
    }
    else if (CompileShaderType == ShaderType::Fragment)
    {
        FunctionName = @"MainPS";
    }
    id<MTLFunction> Function = [Library newFunctionWithName:FunctionName];
    MShaders.push_back(static_cast<void*>(Function));
    return MShaders.size() - 1;
}

void* MetalDevice::GetShader(uint32 Index)
{
    if (MShaders.size() <= Index)
    {
        return nullptr;
    }
    return MShaders[Index];
}

MetalDevice* MetalDevice::Get()
{
    static MetalDevice* MetalDeviceInst = new MetalDevice();
    return MetalDeviceInst;
}

void MetalDevice::Draw(uint32 VertexShaderIndex, uint32 FragmentShaderIndex)
{
    void* VertexShader = GetShader(VertexShaderIndex);
    void* FragmentShader = GetShader(FragmentShaderIndex);
    if (VertexShader == nullptr || FragmentShader == nullptr)
    {
        return;
    }
    id <MTLFunction> VertexFunction = static_cast<id<MTLFunction>>(VertexShader);
    id <MTLFunction> FragmentFunction = static_cast<id<MTLFunction>>(FragmentShader);
    
    MTLRenderPipelineDescriptor* Descriptor = [[MTLRenderPipelineDescriptor alloc]init];
    Descriptor.vertexFunction = VertexFunction;
    Descriptor.fragmentFunction = FragmentFunction;
    Descriptor.colorAttachments[0].pixelFormat = MTLPixelFormatBGRA8Unorm;
    
    id<MTLRenderPipelineState> PipelineState = [MMetalView.device newRenderPipelineStateWithDescriptor:Descriptor error:nil];
    
    float VertexArray[] = {
        1.0f,  1.0f, 0.0f,
        -1.0f, -1.0f, 0.0f,
        1.0f, -1.0f, 0.0f
    };
    id<MTLBuffer> VertexBuffer = [MMetalView.device newBufferWithBytes:VertexArray length:sizeof(VertexArray) options:MTLResourceCPUCacheModeDefaultCache];
    
    id<MTLCommandQueue> CommandQueue = [MMetalView.device newCommandQueue];
    id<MTLCommandBuffer> CommandBuffer = [CommandQueue commandBuffer];
    
    MTLRenderPassDescriptor* RenderPassDes = [[MTLRenderPassDescriptor alloc]init];
    RenderPassDes.colorAttachments[0].texture = [MMetalView.currentDrawable texture];
    RenderPassDes.colorAttachments[0].loadAction = MTLLoadActionClear;
    RenderPassDes.colorAttachments[0].clearColor = MTLClearColorMake(1.0, 1.0, 1.0, 1.0);
    
    id<MTLRenderCommandEncoder> RenderEncoder = [CommandBuffer renderCommandEncoderWithDescriptor:RenderPassDes];
    [RenderEncoder setRenderPipelineState:PipelineState];
    [RenderEncoder setVertexBuffer:VertexBuffer offset:0 atIndex:0];
    RenderEncoder.label = @"Draw";
    
    [RenderEncoder drawPrimitives:MTLPrimitiveTypeTriangleStrip vertexStart:0 vertexCount:3];
    [RenderEncoder endEncoding];

    [CommandBuffer presentDrawable:static_cast<id<MTLDrawable>>(MMetalView.currentDrawable)];
    [CommandBuffer commit];
    
    [PipelineState release];
    [Descriptor release];
    [VertexBuffer release];
    [CommandQueue release];
    [CommandBuffer release];
    [RenderPassDes release];
    [RenderEncoder release];
}

ENGINE_END()
