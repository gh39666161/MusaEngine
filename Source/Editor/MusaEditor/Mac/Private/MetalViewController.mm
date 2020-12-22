//
//  GameViewController.mm
//  MusaEngine
//
//  Created by musa on 2020/12/18.
//  Copyright © 2020 musa. All rights reserved.
//

#import "Render/MetalRHI/Public/MetalRHI.h"
#import "Render/MetalRHI/Public/MetalRenderer.h"
#import "MusaEditor/Mac/Public/AppDelegate.h"
#import "MusaEditor/Mac/Public/MetalViewController.h"

@implementation MetalViewController
{
    MTKView *_view;
    MetalRenderer *_renderer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _view = (MTKView *)self.view;

    _view.device = [MTLCreateSystemDefaultDevice() autorelease];

    if(!_view.device)
    {
        NSLog(@"Metal is not supported on this device");
        self.view = [[[NSView alloc] initWithFrame:self.view.frame] autorelease];
        return;
    }

    _renderer = [[MetalRenderer alloc] initWithMetalKitView:_view];
    [_renderer mtkView:_view drawableSizeWillChange:_view.bounds.size];
    GMODULE(MusaEngine::CMetalRHI)->SetMetalRenderer(_renderer);
    _view.delegate = _renderer;
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[NSApplication sharedApplication] delegate];
    [appDelegate launchMusaEngine];
}

@end
