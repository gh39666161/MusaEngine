//
//  AppDelegate.mm
//  MusaEngine
//
//  Created by musa on 2020/12/18.
//  Copyright © 2020 musa. All rights reserved.
//

#import "Launch/Public/Launch.h"
#import "MusaEditor/Mac/Public/MetalApplication.h"
#import "MusaEditor/Mac/Public/AppDelegate.h"

@interface AppDelegate ()
@end

@implementation AppDelegate {
    NSThread* _engineThread;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    [self quitMusaEngine];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

-(void)launchMusaEngine{
    _engineThread = [[NSThread alloc] initWithTarget:self selector:@selector(startMusaEngineThread:) object:nil];
    _engineThread.name = @"MusaMain";
    [_engineThread start];
}

-(void)startMusaEngineThread: (id)param {
    MusaEngine::CMetalApplication GMetalApp;
    MusaEngine::CLaunch::Launch(static_cast<MusaEngine::CApplication*>(&GMetalApp));
}

-(void)quitMusaEngine {
    MusaEngine::CLaunch::GetApp()->Quit();
    while ([_engineThread isCancelled] == NO && [_engineThread isFinished] == NO){
        [NSThread sleepForTimeInterval:0.1];
    }
    [_engineThread release];
}

@end
