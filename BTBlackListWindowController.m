//
//  BTBlackListWindowController.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/8/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "BTBlackListWindowController.h"


@implementation BTBlackListWindowController

- (id)init {
    self = [super initWithWindowNibName:@"BlackListWindow"];
    if ( self ) {
        blackList = [[NSMutableArray alloc] init];
    }
    return self;
}
                     
 - (void) dealloc {
     [blackList release];
     [super dealloc];
 }


- (IBAction)addItem:(id)sender {
    [blackList addObject:@"New Site"];
    [tableView reloadData];
}


- (IBAction)removeItem:(id)sender {
    [blackList removeObjectAtIndex:[tableView selectedRow]];
    [tableView reloadData];
}

- (IBAction)applyChanges:(id)sender {
    // Actually update a black list.
}

- (id)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)aTableColumn
            row:(int)rowIndex
{
    return [blackList objectAtIndex:rowIndex];
}


- (void)tableView:(NSTableView *)aTableView
   setObjectValue:anObject
   forTableColumn:(NSTableColumn *)aTableColumn
              row:(int)rowIndex
{
    [blackList removeObjectAtIndex:rowIndex];
    [blackList insertObject:anObject atIndex:rowIndex];
    
}

- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return [blackList count];
}



@end
