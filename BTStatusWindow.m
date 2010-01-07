//
//  untitled.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/7/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "BTStatusWindow.h"


@implementation BTStatusWindow


- (id)init {
    
    // Size of screen
    NSRect screenRect = [[NSScreen mainScreen] frame];
    
    NSRect windowRect;
    windowRect.size.width = 200;
    windowRect.size.height = 100;
    windowRect.origin.x = screenRect.size.width - windowRect.size.width - 20;
    windowRect.origin.y = screenRect.size.height - windowRect.size.height - 40;
    
    NSWindow* window = [[NSWindow alloc] initWithContentRect:windowRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];
    
    
    self = [super initWithWindow:window];
    if (self) {
        
        
    }
    return self;
}


@end
