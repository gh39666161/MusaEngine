#import <MetalKit/MetalKit.h>
#import "Render/MetalRHI/Public/MetalRenderer.h"

@interface MetalView : MTKView
    @property(nonnull, retain, nonatomic) MetalRenderer* metalRenderer;
@end

