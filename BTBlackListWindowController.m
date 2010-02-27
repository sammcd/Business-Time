//
//  BTBlackListWindowController.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/8/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "BTBlackListWindowController.h"
#import "BTBlackListModel.h"
#import "BTModel.h"


@implementation BTBlackListWindowController

- (id)init {
    self = [super initWithWindowNibName:@"BlackListWindow"];
    if ( self ) {
        blackList = [[BTModel sharedModel] blackListModel];
    }
    return self;
}
                     
 - (void) dealloc {
     [super dealloc];
 }


- (IBAction)addItem:(id)sender {
    [blackList addSite:@"NewSite.com"];
    [tableView reloadData];
}


- (IBAction)removeItem:(id)sender {
    [self removeSelectedItem];
}

- (void)removeSelectedItem {
    [[blackList siteList] removeObjectAtIndex:[tableView selectedRow]];
    [tableView reloadData];    
}

- (id)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)aTableColumn
            row:(int)rowIndex
{
    return [[blackList siteList] objectAtIndex:rowIndex];
}


- (void)tableView:(NSTableView *)aTableView
   setObjectValue:anObject
   forTableColumn:(NSTableColumn *)aTableColumn
              row:(int)rowIndex
{
    [[blackList siteList] removeObjectAtIndex:rowIndex];
    [[blackList siteList] insertObject:anObject atIndex:rowIndex];
    
}

- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return [blackList count];
}



@end
