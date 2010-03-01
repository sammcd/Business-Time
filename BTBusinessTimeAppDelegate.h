//
//  BusinessTimeAppDelegate.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/7/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

/// @class BTBusinessTimeAppDelegate
/// @brief Application delegate for Business Time
/// Controls Menu bar UI as well as Saving and Loading.

#import <Cocoa/Cocoa.h>
@class BTStatusWindowController, BTBlackListWindowController, BTBusinessTimeController;

@interface BTBusinessTimeAppDelegate : NSObject {
    NSWindow            *window;
    IBOutlet NSMenu     *statusMenu;
    NSStatusItem        *statusItem;
    
    BOOL                            businessTime;
    BTStatusWindowController*       statusWindowController;
    BTBlackListWindowController*    blackListWindowController;
    BTBusinessTimeController*       businessTimeController;
    
    IBOutlet NSMenuItem*            businessTimeButton;
}

@property (assign) IBOutlet NSWindow *window;

/// @brief Turn business time off and on.
- (IBAction)toggleBusinessTime:(id)sender;

/// @brief Open black list editing window
- (IBAction)editBlackList:(id)sender;

/// @brief Quit program.
- (IBAction)quit:(id)sender;

/// @return Returns location of application support folder
- (NSString *)applicationSupportFolder;

/// @return Returns path to file containing data store.
- (NSString *)dataStorePath;

/// @brief Creates folder for application support and loads default data into black list.
- (void)createDefaultDataStoreIfNeeded;



@end
