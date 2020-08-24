#import "EditorApp/Mac/Public/MetalView.h"
#import "EditorApp/Mac/Public/AppDelegate.h"
#import "EditorApp/Mac/Public/WindowDelegate.h"
#import "EditorApp/Mac/Public/MetalApplication.h"
ENGINE_BEGIN()

FMetalApplication GMetalApp;
FApplication* GPApp = &GMetalApp;

FMetalApplication::FMetalApplication():FApplication()
{
    
}

int32 FMetalApplication::Initialize()
{
    CreateMainWindow();
    MetalView* view = [[MetalView alloc] initWithFrame:CGRectMake(0, 0, 1000, 700)];
    [MPWindow setContentView:view];
    return 0;
}

void FMetalApplication::CreateMainWindow()
{
    int result = 0;

    [NSApplication  sharedApplication];

    // Menu
    NSString* appName = @"MusaEngine";
    id menubar = [[NSMenu alloc] initWithTitle:appName];
    id appMenuItem = [NSMenuItem new];
    [menubar addItem: appMenuItem];
    [NSApp setMainMenu:menubar];

    id appMenu = [NSMenu new];
    id quitMenuItem = [[NSMenuItem alloc] initWithTitle:@"Quit"
        action:@selector(terminate:)
        keyEquivalent:@"q"];
    [appMenu addItem:quitMenuItem];
    [appMenuItem setSubmenu:appMenu];

    id appDelegate = [AppDelegate new];
    [NSApp setDelegate: appDelegate];
    [NSApp activateIgnoringOtherApps:YES];
    [NSApp finishLaunching];

    NSInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable |
                      NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable;

    MPWindow = [[NSWindow alloc] initWithContentRect:CGRectMake(200, 50, 1000, 700) styleMask:style backing:NSBackingStoreBuffered defer:NO];
    [MPWindow setTitle:appName];
    [MPWindow makeKeyAndOrderFront:nil];
    id winDelegate = [WindowDelegate new];
    [MPWindow setDelegate:winDelegate];

    return result;
    
}

void FMetalApplication::Finalize()
{
    [MPWindow release];
    FApplication::Finalize();
}

void FMetalApplication::Update()
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
    [event release];
}
ENGINE_END()
