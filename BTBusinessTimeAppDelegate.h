//
//  BusinessTimeAppDelegate.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/7/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class BTStatusWindowController, BTBlackListWindowController, BTBusinessTimeController;

@interface BTBusinessTimeAppDelegate : NSObject /*<NSApplicationDelegate>*/ {
    NSWindow            *window;
    IBOutlet NSMenu     *statusMenu;
    NSStatusItem        *statusItem;
    
    BOOL                            businessTime;
    BTStatusWindowController*       statusWindowController;
    BTBlackListWindowController*    blackListWindowController;
    //IBOutlet NSButton*              businessTimeButton;
    BTBusinessTimeController*       businessTimeController;
    
    IBOutlet NSMenuItem*            businessTimeButton;
}

@property (assign) IBOutlet NSWindow *window;


/// Application support folder.
- (NSString *)applicationSupportFolder;


- (IBAction)toggleBusinessTime:(id)sender;
- (IBAction)editBlackList:(id)sender;


- (IBAction)quit:(id)sender;

@end
