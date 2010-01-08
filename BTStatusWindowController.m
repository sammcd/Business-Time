//
//  untitled.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/7/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "BTStatusWindowController.h"


@implementation BTStatusWindowController


- (id)init {
    
    NSRect screenRect = [[NSScreen mainScreen] frame];
    
    // Create a window to place in the top right of the screen
    NSRect windowRect;
    windowRect.size.width = 150;
    windowRect.size.height = 60;
    windowRect.origin.x = screenRect.size.width - windowRect.size.width - 20;
    windowRect.origin.y = screenRect.size.height - windowRect.size.height - 40;    
    
    NSWindow* window = [[NSWindow alloc] initWithContentRect:windowRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];
    
    NSColor* backgroundColor = [NSColor colorWithCalibratedWhite:0.0 alpha:.6];
    
    [window setOpaque:NO];
    [window setBackgroundColor:backgroundColor];
    [window setLevel	:NSDockWindowLevel];
    [window setCollectionBehavior: NSWindowCollectionBehaviorCanJoinAllSpaces];
    
    // Add a label to the window
    timeTextField = [[NSTextField alloc] init];
    [[window contentView] addSubview:timeTextField];
    [timeTextField setFrame:[[window contentView] bounds]];
    [timeTextField setStringValue:@"0:00"];
    [timeTextField setNeedsDisplay];
    [timeTextField setBackgroundColor:backgroundColor];
    [timeTextField setBordered:NO];
    [timeTextField setFont:[NSFont labelFontOfSize:35.0]];
    [timeTextField setEditable:NO];

    
    self = [super initWithWindow:window];
    if (self) {

    }
    return self;
}

- (void)dealloc {
    [timeTextField release];
    
    if (timeStarted != nil) {
        [timeStarted release];
    }
    
    [super dealloc];
}

- (void)awakeFromNib {
    
    
}


- (void)startTimer {
    NSTimer*         timer;
    
    timeStarted = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    [timer fire];
}
     
- (void)updateTime {
    NSInteger   hours;
    NSInteger   minutes;
    NSInteger   seconds;
    NSString*    minuteString;
    NSString*    secondString;
    NSString*    hourString;

    NSTimeInterval time = 0 - [timeStarted timeIntervalSinceNow];
    
    minutes = (int)time / 60;
    seconds = (int)time % 60;
    hours = (int)minutes / 60;
    
    if ( seconds < 10 ) {
        secondString = [NSString stringWithFormat:@"0%d",seconds];
    } else {
        secondString = [NSString stringWithFormat:@"%d",seconds];
    }
    

    minuteString = [NSString stringWithFormat:@"%d",minutes];
    
    if ( hours == 0 ) {
        hourString = @"";
    } else if ( hours < 10 ) {
        hourString = [NSString stringWithFormat:@"0%d:",hours];
    } else {
        hourString = [NSString stringWithFormat:@"%d:",hours];
    }
    
    [timeTextField setStringValue:[NSString stringWithFormat:@"%@%@:%@",hourString, minuteString, secondString]];
}


@end
