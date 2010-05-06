//
//  BTBusinessTimeController.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 2/9/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "BTBusinessTimeController.h"
#import "BTBlackListModel.h"
#import "BTStatusWindowController.h"
#import "BTModel.h"

@implementation BTBusinessTimeController

#pragma mark init and dealloc
- (id)init {
    self = [super init];
    if (self) {
        isBusinessTime = NO;
    }
    return self;
}

#pragma mark Starting and stopping business time
- (void)startBusinessTime {
    BTBlackListModel* blackListModel = [[BTModel sharedModel] blackListModel];
    
    if (statusWindowController != nil ) {
        [[statusWindowController window] close];
    }
    
    [blackListModel enableFilters];
    isBusinessTime = YES;
}

- (void)stopBusinessTime {
    BTBlackListModel* blackListModel = [[BTModel sharedModel] blackListModel];
    
    statusWindowController = [[BTStatusWindowController alloc] init];
    [[statusWindowController window] makeKeyAndOrderFront:nil];
    [statusWindowController startTimer];
    
    // Disable the host filtering.
    [blackListModel disableFilters];
    isBusinessTime = NO;
}

- (void)toggleBusinessTime {
    if ( isBusinessTime ) 
        [self stopBusinessTime];
    else 
        [self startBusinessTime];
    
}

#pragma mark Returning public variables.
- (BOOL)isBusinessTime {
    return isBusinessTime;
}


@end
