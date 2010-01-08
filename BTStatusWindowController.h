//
//  untitled.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/7/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface BTStatusWindowController : NSWindowController {

    NSTextField*    timeTextField;
    NSDate*          timeStarted;
    
}

- (id)init;

- (void)startTimer;
- (void)updateTime;


@end
