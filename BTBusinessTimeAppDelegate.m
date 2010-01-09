//
//  BusinessTimeAppDelegate.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/7/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "BTBusinessTimeAppDelegate.h"
#import "BTMainWindowController.h"

@implementation BTBusinessTimeAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
}


- (void)awakeFromNib {
    // This nib has awoken lets create our main window.
	BTMainWindowController* mainWindowController = [[BTMainWindowController alloc] initWithWindowNibName:@"MainWindow"];
	[[mainWindowController window] makeKeyAndOrderFront:self];
}

- (void)applicationDidFinishLaunching:(NSNotification*)notification {
    
    // todo add loading code
}

- (void)applicationWillTerminate:(NSNotification *)application {
    // todo add saving code
    
}



- (NSString *)applicationSupportFolder {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    return [basePath stringByAppendingPathComponent:@"Launcher"];
}

@end
