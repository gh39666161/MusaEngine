#import "MusaEditor/Mac/Public/MetalView.h"
#import "MusaEditor/Mac/Public/AppDelegate.h"
#import "MusaEditor/Mac/Public/WindowDelegate.h"
#import "MusaEditor/Mac/Public/MetalApplication.h"

namespace MusaEngine
{
    CMetalApplication::CMetalApplication():CApplication()
    {
        
    }

    int32 CMetalApplication::Initialize()
    {
        CreateMainWindow();
        MetalView* view = [[MetalView alloc] initWithFrame:CGRectMake(0, 0, 1000, 700)];
        [MPWindow setContentView:view];
        [view release];
        return 0;
    }

    void CMetalApplication::CreateMainWindow()
    {
        int result = 0;

        [NSApplication  sharedApplication];
        id appDelegate = [[AppDelegate alloc] init];
        [NSApp setDelegate: appDelegate];
        [appDelegate release];
        [NSApp activateIgnoringOtherApps:YES];
        [NSApp finishLaunching];
        
        // Menu
        NSString* appName = @"MusaEditor";
        id menubar = [[NSMenu alloc] initWithTitle:appName];
        id appMenuItem = [[NSMenuItem alloc] init];
        [menubar addItem: appMenuItem];
        [NSApp setMainMenu:menubar];

        id appMenu = [[NSMenu alloc] init];
        id quitMenuItem = [[NSMenuItem alloc] initWithTitle:@"Quit"
            action:@selector(terminate:)
            keyEquivalent:@"q"];
        [appMenu addItem:quitMenuItem];
        [appMenuItem setSubmenu:appMenu];

        NSInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable |
                          NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable;

        MPWindow = [[NSWindow alloc] initWithContentRect:CGRectMake(200, 50, 1000, 700) styleMask:style backing:NSBackingStoreBuffered defer:NO];
        [MPWindow setTitle:appName];
        [MPWindow makeKeyAndOrderFront:nil];
        id winDelegate = [WindowDelegate alloc];
        [MPWindow setDelegate:winDelegate];
        
        [menubar release];
        [appMenu release];
        [appMenuItem release];
        [winDelegate release];
        
        return result;
        
    }

    void CMetalApplication::Finalize()
    {
        [MPWindow release];
        CApplication::Finalize();
    }

    void CMetalApplication::Update()
    {
        NSEvent *event = [NSApp nextEventMatchingMask:NSEventMaskAny
        untilDate:nil
        inMode:NSDefaultRunLoopMode
        dequeue:YES];

        switch([(NSEvent *)event type])
        {
            case NSEventTypeKeyDown:
                NSLog(@"Key Down Event Received!");
                break;
            default:
                break;
        }
        [NSApp sendEvent:event];
        [NSApp updateWindows];
    }
}
