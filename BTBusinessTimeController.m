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

- (void)stopBusinessTime {
    BTBlackListModel* blackListModel = [[BTModel sharedModel] blackListModel];
    
    statusWindowController = [[BTStatusWindowController alloc] init];
    [[statusWindowController window] makeKeyAndOrderFront:self];
    [statusWindowController startTimer];
    
    // Disable the host filtering.
    [blackListModel disableFilters];
}

- (void)startBusinessTime {
    BTBlackListModel* blackListModel = [[BTModel sharedModel] blackListModel];
    
    if (statusWindowController != nil ) {
        [[statusWindowController window] close];
    }
    
    [blackListModel enableFilters];
    
}

@end
