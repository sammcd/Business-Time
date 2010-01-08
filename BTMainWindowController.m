//
//  MainWindowController.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/7/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "BTMainWindowController.h"
#import "BTStatusWindowController.h"
#import "BTBlackListWindowController.h"


@implementation BTMainWindowController

- (id)init {
    self = [super init];
    if (self) {
        businessTime = YES;
    }
    return self;
}

- (void)dealloc {
    if ( statusWindowController != nil ) {
        [statusWindowController release];
    }
    if ( blackListWindowController != nil ) {
        [blackListWindowController release];
    }
    
    [super dealloc];	
}

- (IBAction)toggleBusinessTime:(id)sender {
    
    if ( !businessTime ) {
        statusWindowController = [[BTStatusWindowController alloc] init];
        [[statusWindowController window] makeKeyAndOrderFront:self];
        [statusWindowController startTimer];
        
        	
        [businessTimeButton setTitle:@"It's Business Time"];
        businessTime = YES;
    } else {
        if (statusWindowController != nil ) {
            [[statusWindowController window] close];
        }
        businessTime = NO;
        [businessTimeButton setTitle:@"Take a break"];
    }

    
}

- (IBAction)editBlackList:(id)sender {
    if ( blackListWindowController == nil ) {
        blackListWindowController = [[BTBlackListWindowController alloc] init];
    }
    [[blackListWindowController window] makeKeyAndOrderFront:self];
    
}


@end