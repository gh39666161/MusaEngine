#import <MetalKit/MetalKit.h>

@interface MetalRenderer : NSObject
{
    
}

@property(nonnull, strong, readonly, nonatomic) MTKView* mtkView;
@property(nonnull, readonly, nonatomic) id<MTLDevice> device;
@property(nonnull, readonly, nonatomic) id<MTLCommandQueue> commandQueue;
@property(nonnull, strong, readonly, nonatomic) NSMutableArray<id<MTLFunction>>* shaders;

- (nonnull instancetype) initWithMetalKitView:(nonnull MTKView*) mtkView
device:(nonnull id<MTLDevice>) device;
- (NSUInteger)compileShader:(nonnull NSString*) source functionName: (nonnull NSString*) name;
- (id<MTLFunction>_Nullable) getShader:(NSUInteger) shaderIndex;

- (void) drawDebug:(NSUInteger) vertexShaderIndex Fragment:(NSUInteger) fragmentShaderIndex;

@end
