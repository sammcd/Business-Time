//
//  BTStatusWindowController.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/7/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

/// @class BTStatusWindowController
/// @brief Window Controller for the Status window
/// The status window is a grey window that appears on top of 
/// everything to count the amount of time spent taking a break.

#import <Cocoa/Cocoa.h>


@interface BTStatusWindowController : NSWindowController {

    NSTextField*    timeTextField;
    NSDate*          timeStarted;
    
}

/// @brief Start the timer.
- (void)startTimer;


@end
