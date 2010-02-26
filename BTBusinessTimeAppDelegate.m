//
//  BusinessTimeAppDelegate.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/7/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "BTBusinessTimeAppDelegate.h"
#import "BTModel.h"
#import "BTBlackListModel.h"
#import "FTHostsController.h"
#import "BTStatusWindowController.h"
#import "BTBlackListWindowController.h"
#import "BTBusinessTimeController.h"

@implementation BTBusinessTimeAppDelegate

@synthesize window;


- (void)awakeFromNib {
    
    // Create status bar.
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
    [statusItem setMenu:statusMenu];
    [statusItem setTitle:@"BT"];
    [statusItem setHighlightMode:YES];
    businessTimeController = [[BTBusinessTimeController alloc] init];
        
}

- (void)applicationDidFinishLaunching:(NSNotification*)notification {

    NSString* saveDirectory = [self applicationSupportFolder];
    NSString* appFile = [saveDirectory stringByAppendingPathComponent:@"BTSave"];

    [NSKeyedUnarchiver unarchiveObjectWithFile:appFile];
        
    [businessTimeController startBusinessTime];	
}


- (void)applicationWillTerminate:(NSNotification *)application {

    BTModel* sharedModel = [BTModel sharedModel];
    NSString* saveDirectory = [self applicationSupportFolder];
    NSString* appFile = [saveDirectory stringByAppendingPathComponent:@"BTSave"];
    
    // Since the object is a singleton that responds to this properly, this will work
    [NSKeyedArchiver archiveRootObject:sharedModel toFile:appFile];
    [[NSUserDefaults standardUserDefaults] setObject:sharedModel forKey:@"sharedModel"];
    [[[BTModel sharedModel] blackListModel] disableFilters];
    
    // an extra flush dns call 
    // our flush dns method isn't ideal, it seems to only work if a connection is not 
    // currently in progress.
    // We should move to using apple's firewall to fix this need.
    [FTHostsController flushDNS];
}


- (NSString *)applicationSupportFolder {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    return [basePath stringByAppendingPathComponent:@"BusinessTime"];
}


- (void)dealloc {
    if ( statusWindowController != nil ) {
        [statusWindowController release];
    }
    if ( blackListWindowController != nil ) {
        [blackListWindowController release];
    }
    
    [super dealloc];	
}

- (IBAction)toggleBusinessTime:(id)sender {
    [businessTimeController toggleBusinessTime];
    
    if ( [businessTimeController isBusinessTime] ) 
        [businessTimeButton setTitle:@"Take a break"];
    else 
        [businessTimeButton setTitle:@"It's Business Time"];

}


- (IBAction)editBlackList:(id)sender {
    if ( blackListWindowController == nil ) {
        blackListWindowController = [[BTBlackListWindowController alloc] init];
    }
    [NSApp activateIgnoringOtherApps:YES];
    [[blackListWindowController window] makeKeyAndOrderFront:self];
    
}

- (IBAction)quit:(id)sender {
    [NSApp terminate:self];
}

@end
