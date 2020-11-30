#pragma once
#import <MetalKit/MetalKit.h>

@interface MetalRenderer : NSObject
{
    
}

@property(nonnull, retain, nonatomic) MTKView* mtkView;
@property(nonnull, retain, nonatomic) id<MTLDevice> device;
@property(nonnull, retain, nonatomic) id<MTLCommandQueue> commandQueue;
@property(nonnull, retain, nonatomic) NSMutableArray<id<MTLFunction>>* shaders;

- (nonnull instancetype) initWithMetalKitView:(nonnull MTKView*) mtkView
device:(nonnull id<MTLDevice>) device;
- (NSInteger)compileShader:(nonnull NSString*) source functionName: (nonnull NSString*) name;
- (id<MTLFunction>_Nullable) getShader:(NSInteger) shaderIndex;
- (void) drawFrame;
- (void) draw;
@end
