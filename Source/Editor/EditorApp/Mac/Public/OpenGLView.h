#pragma once
#import <Cocoa/Cocoa.h>

@interface OpenGLView : NSView
{
    @private
    NSOpenGLContext* _openGLContext;
    NSOpenGLPixelFormat* _pixelFormat;
};
@end
