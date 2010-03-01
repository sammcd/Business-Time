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

#pragma mark Overriding NSObject
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

#pragma mark Adding and removing items
- (IBAction)addItem:(id)sender {
    NSInteger newRowNumber;
    
    [blackList addSite:@"NewSite.com"];
    [tableView reloadData];
    
    newRowNumber = [tableView numberOfRows] - 1;
    [tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:newRowNumber] byExtendingSelection:NO];    
}


- (IBAction)removeItem:(id)sender {
    [self removeSelectedItem];
}

- (void)removeSelectedItem {
    NSInteger newRowNumber;
    newRowNumber = [tableView selectedRow] - 1;

    [[blackList siteList] removeObjectAtIndex:[tableView selectedRow]];
    [tableView reloadData];    
    
    
    [tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:newRowNumber] byExtendingSelection:NO];
}

#pragma mark TableView delegate methods.
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
    // Strip "http://" from new object.
    // This does not work with hosts
    NSString* newString = [anObject stringByReplacingOccurrencesOfString:@"http://" withString:@""]; 
    
    [[blackList siteList] removeObjectAtIndex:rowIndex];
    [[blackList siteList] insertObject:newString atIndex:rowIndex];
    
}

- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return [blackList count];
}



@end
