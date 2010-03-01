//
//  BTBlackListWindowController.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/8/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

/// @class BTBlackListWindowController
/// @brief Window controller to control ban list window.


#import <Cocoa/Cocoa.h>
@class  BTBlackListModel;


@interface BTBlackListWindowController : NSWindowController {
    BTBlackListModel*    blackList;
    IBOutlet NSTableView* tableView;
    
}

/// @brief IBAction to add a new item
- (IBAction)addItem:(id)sender;

/// @brief IBAction to remove selected item
- (IBAction)removeItem:(id)sender;

/// @breif Remove selected item.
- (void)removeSelectedItem;

@end
