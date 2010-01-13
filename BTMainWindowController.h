//
//  MainWindowController.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/7/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class BTStatusWindowController, BTBlackListWindowController;


@interface BTMainWindowController : NSWindowController {
    BOOL                            businessTime;
    BTStatusWindowController*       statusWindowController;
    BTBlackListWindowController*    blackListWindowController;
    IBOutlet NSButton*              businessTimeButton;
}

- (IBAction)toggleBusinessTime:(id)sender;
- (IBAction)editBlackList:(id)sender;

- (void)startBusinessTime;
- (void)stopBusinessTime;
@end
