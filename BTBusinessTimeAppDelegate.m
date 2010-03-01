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

#pragma mark Override NSObject
- (void)dealloc {
    if ( statusWindowController != nil ) {
        [statusWindowController release];
    }
    if ( blackListWindowController != nil ) {
        [blackListWindowController release];
    }
    if ( businessTimeController != nil ) {
        [businessTimeController release];
    }
    
    [super dealloc];	
}

#pragma mark IBActions
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

#pragma mark Saving/Loading
- (void)createDefaultDataStoreIfNeeded {
    NSFileManager*      fileManager = [NSFileManager defaultManager];
    BTModel*            sharedModel = [BTModel sharedModel];
    BTBlackListModel*   blackList = [sharedModel blackListModel];
    
    if ( ![fileManager fileExistsAtPath:[self dataStorePath]] ) {        
        [blackList addSite:@"www.google.com"];
        [blackList addSite:@"google.com"];
        [blackList addSite:@"twitter.com"];
    }
    
    // Now create the folder in applicaiton support if it doesn't exist.
    if ( ![fileManager fileExistsAtPath:[self applicationSupportFolder]] ) {
        NSError* error;
        
        [fileManager createDirectoryAtPath:[self applicationSupportFolder] 
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:&error];
    }
}

- (NSString *)applicationSupportFolder {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    return [basePath stringByAppendingPathComponent:@"BusinessTime"];
}

- (NSString *)dataStorePath {
    return [[self applicationSupportFolder] stringByAppendingPathComponent:@"BTSave"];
}


#pragma mark Application Delegate Methods
- (void)awakeFromNib {
    
    // Create status bar.
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
    [statusItem setMenu:statusMenu];
    [statusItem setTitle:@"BT"];
    [statusItem setHighlightMode:YES];
    businessTimeController = [[BTBusinessTimeController alloc] init];
        
}

- (void)applicationDidFinishLaunching:(NSNotification*)notification {
    NSString* appFile = [self dataStorePath];
    
    // Currently the route of unarchiving works, but it is not 
    // the best route. Archiving with a singleton was a bad idea :(
    [NSKeyedUnarchiver unarchiveObjectWithFile:appFile];
    
    [self createDefaultDataStoreIfNeeded];
    [businessTimeController startBusinessTime];	
}


- (void)applicationWillTerminate:(NSNotification *)application {

    BTModel* sharedModel = [BTModel sharedModel];
    NSString* appFile = [self dataStorePath];
    
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

@end
