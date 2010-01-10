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

@implementation BTBusinessTimeAppDelegate

@synthesize window;


- (void)awakeFromNib {
    // This nib has awoken lets create our main window.
	BTMainWindowController* mainWindowController = [[BTMainWindowController alloc] initWithWindowNibName:@"MainWindow"];
	[[mainWindowController window] makeKeyAndOrderFront:self];
}

- (void)applicationDidFinishLaunching:(NSNotification*)notification {
    NSString* saveDirectory = [self applicationSupportFolder];
    NSString* appFile = [saveDirectory stringByAppendingPathComponent:@"BTSave"];

    [NSKeyedUnarchiver unarchiveObjectWithFile:appFile];

    
    
}

- (void)applicationWillTerminate:(NSNotification *)application {
    BTModel* sharedModel = [BTModel sharedModel];
    NSString* saveDirectory = [self applicationSupportFolder];
    NSString* appFile = [saveDirectory stringByAppendingPathComponent:@"BTSave"];
    
    // Since the object is a singleton that responds to this properly, this will work
    [NSKeyedArchiver archiveRootObject:sharedModel toFile:appFile];
}



- (NSString *)applicationSupportFolder {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    return [basePath stringByAppendingPathComponent:@"BusinessTime"];
}

@end
