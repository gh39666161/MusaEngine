//
//  MetalRenderer.h
//  MusaEngine
//
//  Created by musa on 2020/12/18.
//  Copyright © 2020 musa. All rights reserved.
//

#import <MetalKit/MetalKit.h>

// Our platform independent renderer class.   Implements the MTKViewDelegate protocol which
//   allows it to accept per-frame update and drawable resize callbacks.
@interface MetalRenderer : NSObject <MTKViewDelegate>

-(nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)view;
- (NSInteger)compileShader:(nonnull NSString*) source functionName: (nonnull NSString*) name;
- (id<MTLFunction>_Nullable) getShader:(NSInteger) shaderIndex;
@end

