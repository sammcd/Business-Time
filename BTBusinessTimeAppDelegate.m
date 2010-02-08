//
//  BusinessTimeAppDelegate.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/7/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "BTBusinessTimeAppDelegate.h"
#import "BTMainWindowController.h"
#import "BTModel.h"
#import "BTBlackListModel.h"
#import "FTHostsController.h"
#import "BTStatusWindowController.h"
#import "BTBlackListWindowController.h"

@implementation BTBusinessTimeAppDelegate

@synthesize window;


- (void)awakeFromNib {
    // This nib has awoken lets create our main window.
	//BTMainWindowController* mainWindowController = [[BTMainWindowController alloc] initWithWindowNibName:@"MainWindow"];
	//[[mainWindowController window] makeKeyAndOrderFront:self];
    
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
    [statusItem setMenu:statusMenu];
    [statusItem setTitle:@"BT"];
    [statusItem setHighlightMode:YES];
    businessTime = NO;
}

- (void)applicationDidFinishLaunching:(NSNotification*)notification {

    NSString* saveDirectory = [self applicationSupportFolder];
    NSString* appFile = [saveDirectory stringByAppendingPathComponent:@"BTSave"];

    [NSKeyedUnarchiver unarchiveObjectWithFile:appFile];
    
    [[[BTModel sharedModel] blackListModel] enableFilters];
    [FTHostsController flushDNS];
    
}

- (void)applicationWillTerminate:(NSNotification *)application {

    BTModel* sharedModel = [BTModel sharedModel];
    NSString* saveDirectory = [self applicationSupportFolder];
    NSString* appFile = [saveDirectory stringByAppendingPathComponent:@"BTSave"];
    
    // Since the object is a singleton that responds to this properly, this will work
    [NSKeyedArchiver archiveRootObject:sharedModel toFile:appFile];
    
    [[[BTModel sharedModel] blackListModel] disableFilters];
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
    
    if ( !businessTime ) {
        NSLog(@"stopping Business Time: %d", businessTime);
        [self stopBusinessTime];
        
    } else {
        NSLog(@"Starting business Time: %d", businessTime);
        [self startBusinessTime];
        
    }
}



- (void)stopBusinessTime {
    BTBlackListModel* blackListModel = [[BTModel sharedModel] blackListModel];
    
    statusWindowController = [[BTStatusWindowController alloc] init];
    [[statusWindowController window] makeKeyAndOrderFront:self];
    [statusWindowController startTimer];
    [businessTimeButton setTitle:@"It's Business Time"];
    businessTime = YES;
    
    // Disable the host filtering.
    [blackListModel disableFilters];
}

- (void)startBusinessTime {
    BTBlackListModel* blackListModel = [[BTModel sharedModel] blackListModel];
    
    if (statusWindowController != nil ) {
        [[statusWindowController window] close];
    }
    businessTime = NO;
    [businessTimeButton setTitle:@"Take a break"];
    
    [blackListModel enableFilters];
    
}

- (IBAction)editBlackList:(id)sender {
    if ( blackListWindowController == nil ) {
        blackListWindowController = [[BTBlackListWindowController alloc] init];
    }
    [[blackListWindowController window] makeKeyAndOrderFront:self];
    
}

- (IBAction)quit:(id)sender {
    [NSApp terminate:self];
}

@end
