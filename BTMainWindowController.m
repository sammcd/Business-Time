//
//  MainWindowController.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/7/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "BTMainWindowController.h"
#import "BTStatusWindowController.h"


@implementation BTMainWindowController

- (id)init {
    self = [super init];
    if (self) {
        businessTime = YES;
    }
    return self;
}

- (IBAction)toggleBusinessTime:(id)sender {
    
    if ( !businessTime ) {
        statusWindowController = [[BTStatusWindowController alloc] init];
        [[statusWindowController window] makeKeyAndOrderFront:self];
        [businessTimeButton setTitle:@"Its Business Time"];
        businessTime = YES;
    } else {
        if (statusWindowController != nil ) {
            [[statusWindowController window] close];
        }
        businessTime = NO;
        [businessTimeButton setTitle:@"Take a break"];
    }

    
}


@end