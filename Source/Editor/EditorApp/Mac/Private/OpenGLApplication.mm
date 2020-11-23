#include <string.h>
#import "EditorApp/Mac/Public/AppDelegate.h"
#import "EditorApp/Mac/Public/WindowDelegate.h"
#import "EditorApp/Mac/Public/OpenGLView.h"
#import "EditorApp/Mac/Public/OpenGLApplication.h"

namespace MusaEngine
{
    //FOpenGLApplication GOpenGLApp;
    //FApplication* GPApp = &GOpenGLApp;

    FOpenGLApplication::FOpenGLApplication():FApplication()
    {
        
    }

    int32 FOpenGLApplication::Initialize()
    {
        CreateMainWindow();
        
        OpenGLView* view = [[OpenGLView alloc] initWithFrame:CGRectMake(0, 0, 1000, 700)];
        [MPWindow setContentView:view];
        [view release];
        return 0;
    }

    void FOpenGLApplication::CreateMainWindow()
    {
        int result = 0;

        [NSApplication  sharedApplication];

        // Menu
        NSString* appName = @"MusaEngine";
        id menubar = [[NSMenu alloc] initWithTitle:appName];
        id appMenuItem = [NSMenuItem new];
        [menubar addItem: appMenuItem];
        [NSApp setMainMenu:menubar];

        id appMenu = [NSMenu alloc];
        id quitMenuItem = [[NSMenuItem alloc] initWithTitle:@"Quit"
            action:@selector(terminate:)
            keyEquivalent:@"q"];
        [appMenu addItem:quitMenuItem];
        [appMenuItem setSubmenu:appMenu];

        id appDelegate = [AppDelegate alloc];
        [NSApp setDelegate: appDelegate];
        [NSApp activateIgnoringOtherApps:YES];
        [NSApp finishLaunching];

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
        [appDelegate release];
        [winDelegate release];

        return result;
        
    }

    void FOpenGLApplication::Finalize()
    {
        [MPWindow release];
        FApplication::Finalize();
    }

    void FOpenGLApplication::Update()
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

