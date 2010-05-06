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

- (id)init {
    self = [super init];
    if (self) {
        isBusinessTime = NO;
        beginningOfSession = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    }
    return self;
}

- (void)startBusinessTime {
    BTBlackListModel* blackListModel = [[BTModel sharedModel] blackListModel];
    
    if (statusWindowController != nil ) {
        [[statusWindowController window] close];
    }
    
    [beginningOfSession release];
    beginningOfSession = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    
    [blackListModel enableFilters];
    isBusinessTime = YES;
}

- (void)stopBusinessTime {
    BTBlackListModel* blackListModel = [[BTModel sharedModel] blackListModel];
    
    statusWindowController = [[BTStatusWindowController alloc] init];
    [[statusWindowController window] makeKeyAndOrderFront:nil];
    [statusWindowController startTimer];
    
    [beginningOfSession release];
    beginningOfSession = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    
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

- (BOOL)isBusinessTime {
    return isBusinessTime;
}

- (NSTimeInterval)timeOfCurrentSession {
    NSLog(@"hello");
    
    return [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSinceDate:beginningOfSession];
}


@end
