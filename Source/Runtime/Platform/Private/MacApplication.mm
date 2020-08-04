#import "AppDelegate.h"
#import "WindowDelegate.h"
#include "MacApplication.h"
ENGINE_BEGIN()
FMacApplication::FMacApplication():FApplication()
{
    
}

int32 FMacApplication::Initialize()
{
    CreateMainWindow();
    return 0;
}

void FMacApplication::CreateMainWindow()
{
    [NSApplication sharedApplication];

    // Menu
    NSString* appName = @"MusaEngine";
    id menubar = [[NSMenu alloc] initWithTitle:appName];
    id appMenuItem = [NSMenuItem new];
    [menubar addItem:appMenuItem];
    [NSApp setMainMenu:menubar];
    [menubar release];

    id appMenu = [NSMenu new];
    id quitMenuItem = [[NSMenuItem alloc] initWithTitle:@"Quit"
                                                 action:@selector(terminate:)
                                          keyEquivalent:@"q"];
    [appMenu addItem:quitMenuItem];
    [appMenuItem setSubmenu:appMenu];
    [appMenu release];
    [appMenuItem release];

    id appDelegate = [AppDelegate new];
    [NSApp setDelegate:appDelegate];
    [appDelegate release];
    [NSApp activateIgnoringOtherApps:YES];
    [NSApp finishLaunching];

    NSInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable |
                      NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable;

    MPWindow = [[NSWindow alloc]
        initWithContentRect:CGRectMake(0, 0, 500, 500)
                  styleMask:style
                    backing:NSBackingStoreBuffered
                      defer:NO];
    id winDelegate = [WindowDelegate new];
    [MPWindow setDelegate:winDelegate];
    [winDelegate release];
    [MPWindow setTitle:appName];
    [MPWindow makeKeyAndOrderFront:nil];
    [MPWindow makeMainWindow];
}

void FMacApplication::Finalize()
{
    [MPWindow release];
    FApplication::Finalize();
}

void FMacApplication::Update()
{
    while (NSEvent* event = [NSApp nextEventMatchingMask:NSEventMaskAny untilDate:nil inMode:NSDefaultRunLoopMode dequeue:YES])
    {
        switch ([(NSEvent*)event type]) {
            case NSEventTypeKeyUp:
                NSLog(@"[CocoaApp] Key Up Event Received!");
                if ([event modifierFlags] & NSEventModifierFlagNumericPad) {
                    // arrow keys
//                    NSString* theArrow = [event charactersIgnoringModifiers];
//                    unichar keyChar = 0;
//                    if ([theArrow length] == 1) {
//                        keyChar = [theArrow characterAtIndex:0];
//                        if (keyChar == NSLeftArrowFunctionKey) {
//                            g_pInputManager->LeftArrowKeyUp();
//                            break;
//                        }
//                        if (keyChar == NSRightArrowFunctionKey) {
//                            g_pInputManager->RightArrowKeyUp();
//                            break;
//                        }
//                        if (keyChar == NSUpArrowFunctionKey) {
//                            g_pInputManager->UpArrowKeyUp();
//                            break;
//                        }
//                        if (keyChar == NSDownArrowFunctionKey) {
//                            g_pInputManager->DownArrowKeyUp();
//                            break;
//                        }
//                    }
                } else {
//                    switch ([event keyCode]) {
//                        case kVK_ANSI_D:  // d key
//                            InputManager::AsciiKeyUp('d');
//                            break;
//                        case kVK_ANSI_R:  // r key
//                            InputManager::AsciiKeyUp('r');
//                            break;
//                        case kVK_ANSI_U:  // u key
//                            InputManager::AsciiKeyUp('u');
//                            break;
//                    }
                }
                break;
            case NSEventTypeKeyDown:
                NSLog(@"[CocoaApp] Key Down Event Received! keycode=%d", [event keyCode]);
                if ([event modifierFlags] & NSEventModifierFlagNumericPad) {
                    // arrow keys
//                    NSString* theArrow = [event charactersIgnoringModifiers];
//                    unichar keyChar = 0;
//                    if ([theArrow length] == 1) {
//                        keyChar = [theArrow characterAtIndex:0];
//                        if (keyChar == NSLeftArrowFunctionKey) {
//                            g_pInputManager->LeftArrowKeyDown();
//                            break;
//                        }
//                        if (keyChar == NSRightArrowFunctionKey) {
//                            g_pInputManager->RightArrowKeyDown();
//                            break;
//                        }
//                        if (keyChar == NSUpArrowFunctionKey) {
//                            g_pInputManager->UpArrowKeyDown();
//                            break;
//                        }
//                        if (keyChar == NSDownArrowFunctionKey) {
//                            g_pInputManager->DownArrowKeyDown();
//                            break;
//                        }
//                    }
                } else {
//                    switch ([event keyCode]) {
//                        case kVK_ANSI_D:  // d key
//                            My::InputManager::AsciiKeyDown('d');
//                            break;
//                        case kVK_ANSI_R:  // r key
//                            My::InputManager::AsciiKeyDown('r');
//                            break;
//                        case kVK_ANSI_U:  // u key
//                            My::InputManager::AsciiKeyDown('u');
//                            break;
//                    }
                }
                break;
            default:
                break;
        }
        [NSApp sendEvent:event];
        [NSApp updateWindows];
    }
}
ENGINE_END()
