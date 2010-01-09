//
//  BTBlackListWindowController.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/8/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface BTBlackListWindowController : NSWindowController {
    NSMutableArray*    blackList;
    
    IBOutlet NSTableView* tableView;
    
}

- (IBAction)addItem:(id)sender;
- (IBAction)removeItem:(id)sender;
- (IBAction)applyChanges:(id)sender;


@end
