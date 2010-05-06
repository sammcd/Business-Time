//
//  BTBusinessTimeController.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 2/9/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

/// @class BTBusinessTimeController
/// Controller for logic concerning whether it is "Business Time" or not.


#import <Cocoa/Cocoa.h>
@class BTStatusWindowController;

@interface BTBusinessTimeController : NSObject {
    BTStatusWindowController* statusWindowController;
    
    NSDate*         beginningOfSession;
    BOOL            isBusinessTime;
}

/// @brief block access to black List
- (void)startBusinessTime;

/// @brief Enable access to black list and show timer
- (void)stopBusinessTime;

/// @brief Toggle business time state.
- (void)toggleBusinessTime;

/// @return Returns boolean showing whether we are in business time.
- (BOOL)isBusinessTime;

/// @return Returns amount of time spent in current state (bussiness time or break time)
- (NSTimeInterval)timeOfCurrentSession;


@end
