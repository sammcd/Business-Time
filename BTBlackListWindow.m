//
//  BTBlackListWindow.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 2/27/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "BTBlackListWindow.h"
#import "BTBlackListWindowController.h"


@implementation BTBlackListWindow


- (void)keyDown:(NSEvent *)theEvent {
    [self interpretKeyEvents:[NSArray arrayWithObject:theEvent]];
}

- (void)deleteBackward:(id)sender {
    [blackListWindowController removeSelectedItem];
}

@end
