//
//  BTBlackListWindow.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 2/27/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

/// @class BTBlackListWindow
/// @breif NSWindow subclass to allow delete key to delete blacklist items

#import <Cocoa/Cocoa.h>
@class BTBlackListWindowController;

@interface BTBlackListWindow : NSWindow {
    IBOutlet BTBlackListWindowController* blackListWindowController;
}

@end
