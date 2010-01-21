//
//  BusinessTimeAppDelegate.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/7/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BTBusinessTimeAppDelegate : NSObject /*<NSApplicationDelegate>*/ {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;


/// Application support folder.
- (NSString *)applicationSupportFolder;

@end
