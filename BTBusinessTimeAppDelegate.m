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

@end
