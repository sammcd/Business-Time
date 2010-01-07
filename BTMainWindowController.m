//
//  MainWindowController.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/7/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "BTMainWindowController.h"
#import "BTStatusWindow.h"


@implementation BTMainWindowController

- (IBAction)toggleBusinessTime:(id)sender {
    BTStatusWindow* windowController = [[BTStatusWindow alloc] init];
	[[windowController window] makeKeyAndOrderFront:self];
    
}


@end