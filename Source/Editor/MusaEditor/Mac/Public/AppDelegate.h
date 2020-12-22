//
//  AppDelegate.h
//  MusaEngine
//
//  Created by musa on 2020/12/18.
//  Copyright © 2020 musa. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
-(void)launchMusaEngine;
-(void)startMusaEngineThread: (id)param;
-(void)quitMusaEngine;
@end
