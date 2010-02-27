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
    // Create a window to place in the top right of the screen
    NSRect windowRect;
    NSRect screenRect = [[NSScreen mainScreen] frame];

    windowRect.size.width = 170;
    windowRect.size.height = 60;
    windowRect.origin.x = screenRect.size.width - windowRect.size.width - 20;
    windowRect.origin.y = screenRect.size.height - windowRect.size.height - 40;  
    
    NSWindow* window = [[NSWindow alloc] initWithContentRect:windowRect 
                                                   styleMask:NSBorderlessWindowMask 
                                                     backing:NSBackingStoreBuffered 
                                                       defer:NO];
    
    self = [super initWithWindow:window];
    [self windowDidLoad];
    if (self) {

    }
    return self;
}

- (void)windowDidLoad {
    NSLog(@"window did load");
    
    NSColor* backgroundColor = [NSColor colorWithCalibratedWhite:0.0 alpha:.6];
    
    NSWindow* window = [self window];
    [window setOpaque:NO];
    [window setBackgroundColor:backgroundColor];
    [window setLevel	:NSDockWindowLevel];
    [window setCollectionBehavior: NSWindowCollectionBehaviorCanJoinAllSpaces];
    
    // Add a label to the window
    timeTextField = [[NSTextField alloc] init];
    [[window contentView] addSubview:timeTextField];
    [timeTextField setFont:[NSFont labelFontOfSize:35.0]];
    [timeTextField setStringValue:@"0:00"];
    
    // Set width to width of window, set height to sizeToFit.
    [timeTextField sizeToFit];
    NSRect fitRect = [timeTextField bounds];
    NSRect windowRect = [[window contentView] frame];
    NSRect timeTextFieldRect;
    timeTextFieldRect.origin.x = fitRect.origin.x;
    timeTextFieldRect.origin.y = fitRect.origin.y + 5; // Add padding to bottom
    timeTextFieldRect.size.width = windowRect.size.width;
    timeTextFieldRect.size.height = fitRect.size.height;
    
    [timeTextField setFrame:timeTextFieldRect];
    
    [timeTextField setAutoresizingMask:NSViewMinXMargin | NSViewWidthSizable | NSViewMaxXMargin |
     NSViewMinYMargin | NSViewMaxYMargin ];
    
    [timeTextField setAlignment:NSCenterTextAlignment];
    [timeTextField setNeedsDisplay];
    [timeTextField setBackgroundColor:[NSColor colorWithCalibratedWhite:1.0 alpha:0.0]];
    [timeTextField setTextColor:[NSColor colorWithCalibratedWhite:1.0 alpha:0.9]];
    [timeTextField setBordered:NO];
    [timeTextField setEditable:NO];
}  

- (void)dealloc {
    [timeTextField release];
    [[self window] release];
    
    if (timeStarted != nil) {
        [timeStarted release];
    }
    
    [[self window] release];
    
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
    NSInteger   hours = 0;
    NSInteger   minutes = 0;
    NSInteger   seconds = 0;
    NSString*    minuteString;
    NSString*    secondString;
    NSString*    hourString;

    NSTimeInterval time = 0 - [timeStarted timeIntervalSinceNow];
    
    minutes = (int)time / 60 % 60;
    seconds = (int)time % 60;
    hours = (int)time / 60 / 60;
    
    if ( seconds < 10 ) {
        secondString = [NSString stringWithFormat:@"0%d",seconds];
    } else {
        secondString = [NSString stringWithFormat:@"%d",seconds];
    }
    
    if ( minutes < 10 ) {
        minuteString = [NSString stringWithFormat:@"0%d",minutes];
    } else {
        minuteString = [NSString stringWithFormat:@"%d",minutes];
    }

    
    if ( hours == 0 ) {
        hourString = @"";
    } else {
        hourString = [NSString stringWithFormat:@"%d:",hours];
    }
    
    [timeTextField setStringValue:[NSString stringWithFormat:@"%@%@:%@",hourString, minuteString, secondString]];
}


@end
