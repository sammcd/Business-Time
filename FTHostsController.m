//
//  14HostsController.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/8/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "FTHostsController.h"
#import "FTHost.h"
#import <Security/Security.h>
#import <SecurityFoundation/SFAuthorization.h>


@implementation FTHostsController

- (id)init {
    self = [super init];
    if ( self ) {
        uniqueName = [[NSString alloc] initWithString:@"HostsController"];
        hosts = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [uniqueName release];
    [super dealloc];
}


- (NSString*)readHostsFile {
    return [NSString stringWithContentsOfFile:@"/Users/sammcd/Desktop/hosts" encoding:NSASCIIStringEncoding error:NULL];
}


- (void)writeHostsToFile {
    NSString*   hostsFile;
    NSString*   sectionStart;
    NSString*   sectionEnd;
    NSArray*    hostsArray;
    int         startLine  = -1;
    int         stopLine = -1;
    
    hostsFile = [self readHostsFile];
    
    sectionStart = [NSString stringWithFormat:@"# %@ START",uniqueName];
    sectionEnd = [NSString stringWIthFormat:@"# %@ END",uniqueName];
    
    // now break into lines.
    hostsArray = [hostsFile componentsSeparatedByString:@"\n"];
    
    // Loop through the array looking for the line end and beginning.
    int i;
    for (i = 0; i < [hostsArray count]; i++ ) {
        NSString* line = [hostsArray objectAtIndex:i];
        if ( [line hasSuffix:sectionStart] ) {
            sectionStart = i;
            break;
        }
    }
    
    for (i = 0; i < [hostsArray count]; i++ ) {
        NSString* line = [hostsArray objectAtIndex:i];
        if ( [line hasSuffix:sectionEnd ) {
            sectionEnd = i;
            break;
        }
    }
              
    
    
}

- (void)removeHostsFromFile {
    NSString*   hostsFile;
    
    hostsFile = [self readHostsFile];
    
    
    
}

- (void)setUniqueName:(NSString*)aName {
    NSString* oldName = uniqueName;
    uniqueName = [[NSString alloc] initWithString:aName];
    [oldName release];
}


- (void)loadHosts {
 
    // Load file
    
    // Find section
    
    // Load from section or set a flag that there aren't any to load
}





- (void)addHostWithName:(NSString*)aName ip:(NSString*)ip {
    FTHost* aHost = [[FTHost alloc] init];
    aHost.name = aName;
    aHost.ip = ip;
    
    [hosts addObject:aHost];
}


@end
