//
//  AppDelegate.m
//  Test
//
//  Created by musa on 2020/12/18.
//  Copyright © 2020 musa. All rights reserved.
//

//#import "Runtime/Render/MetalRHI/Public/MetalRHI.h"
//#import "Runtime/Launch/Public/Launch.h"
#import "MusaEditor/Mac/Public/MetalApplication.h"
#import "MusaEditor/Mac/Public/AppDelegate.h"
using namespace MusaEngine;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

-(void)launchMusaEngine {
    CMetalApplication GMetalApp;
//    MusaEngine::CLaunch::Launch(static_cast<CApplication*>(&GMetalApp));
}

@end
