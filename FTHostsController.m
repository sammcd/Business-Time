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

+ (void)flushDNS {
    NSArray* arguments = [NSArray arrayWithObjects:@"-flushcache",nil];
    [NSTask launchedTaskWithLaunchPath:@"" arguments:arguments];
}


- (NSString*)readHostsFile {
    return [NSString stringWithContentsOfFile:@"/Users/sammcd/Desktop/hosts" encoding:NSASCIIStringEncoding error:NULL];
}


- (void)writeHostsToFile {
    NSString*           sectionStart;
    NSString*           sectionEnd;
    NSString*           hostsString;
    NSMutableArray*     hostsArray;
    int                 startLine  = -1;
    int                 stopLine = -1;
    int                 indexToAdd = 0;
    
    hostsArray = [[NSMutableArray alloc] initWithArray:[[self readHostsFile] componentsSeparatedByString:@"\n"]];
    
    sectionStart = [NSString stringWithFormat:@"# %@ START",uniqueName];
    sectionEnd = [NSString stringWithFormat:@"# %@ END",uniqueName];
    
     
    
    // Loop through the array looking for the line end and beginning.
    int i;
    for (i = 0; i < [hostsArray count]; i++ ) {
        NSString* line = [hostsArray objectAtIndex:i];
        if ( [line hasSuffix:sectionStart] ) {
            startLine = i;
            break;
        }
    }
    
    for (i = 0; i < [hostsArray count]; i++ ) {
        NSString* line = [hostsArray objectAtIndex:i];
        if ( [line hasSuffix:sectionEnd] ) {
            stopLine = i;
            break;
        }
    }
              
              
    if ( startLine == -1 ) {
        // There is no section so create it.
        [hostsArray addObject:[NSString stringWithFormat:@"%@",sectionStart]];
        indexToAdd = [hostsArray count];
        [hostsArray addObject:[NSString stringWithFormat:@"%@",sectionEnd]];
        
        
    } else {
        // There is a section so play with it.
        NSRange removeRange;
        removeRange.location = startLine + 1;
        removeRange.length = stopLine - removeRange.location;
        [hostsArray removeObjectsInRange:removeRange];
        indexToAdd = startLine + 1;
    }
    
    // Let create the array of lines that 
    // Should be in the middle
    for ( FTHost* host in hosts ) {
        [hostsArray insertObject:[NSString stringWithFormat:@"%@ %@",host.ip, host.name] atIndex:indexToAdd];
        indexToAdd++;
    }
    
    // Bring array back to string.
    hostsString = [hostsArray componentsJoinedByString:@"\n"];
    NSLog(@"hosts array %d:\n%@",[hostsArray count],hostsArray);
    NSLog(@"hosts string:\n%@",hostsString);
    
    NSError* fileError;
    [hostsString writeToFile:@"/Users/sammcd/Desktop/hosts" atomically:YES encoding:NSASCIIStringEncoding error:&fileError];
        
}

- (void)removeHostsFromFile {
    NSString*           sectionStart;
    NSString*           sectionEnd;
    NSString*           hostsString;
    NSMutableArray*     hostsArray;
    int                 startLine  = -1;
    int                 stopLine = -1;
    int                 indexToAdd = 0;
    
    hostsArray = [[NSMutableArray alloc] initWithArray:[[self readHostsFile] componentsSeparatedByString:@"\n"]];
    
    sectionStart = [NSString stringWithFormat:@"# %@ START",uniqueName];
    sectionEnd = [NSString stringWithFormat:@"# %@ END",uniqueName];
    
    
    
    // Loop through the array looking for the line end and beginning.
    int i;
    for (i = 0; i < [hostsArray count]; i++ ) {
        NSString* line = [hostsArray objectAtIndex:i];
        if ( [line hasSuffix:sectionStart] ) {
            startLine = i;
            break;
        }
    }
    
    for (i = 0; i < [hostsArray count]; i++ ) {
        NSString* line = [hostsArray objectAtIndex:i];
        if ( [line hasSuffix:sectionEnd] ) {
            stopLine = i;
            break;
        }
    }
    
    
    if ( startLine == -1 ) {
        // There is no section so create it.
        [hostsArray addObject:[NSString stringWithFormat:@"%@",sectionStart]];
        indexToAdd = [hostsArray count];
        [hostsArray addObject:[NSString stringWithFormat:@"%@",sectionEnd]];
        
        
    } else {
        // There is a section so play with it.
        NSRange removeRange;
        removeRange.location = startLine + 1;
        removeRange.length = stopLine - removeRange.location;
        [hostsArray removeObjectsInRange:removeRange];
        indexToAdd = startLine + 1;
    }
    

    
    // Bring array back to string.
    hostsString = [hostsArray componentsJoinedByString:@"\n"];
    
    NSError* fileError;
    [hostsString writeToFile:@"/Users/sammcd/Desktop/hosts" atomically:YES encoding:NSASCIIStringEncoding error:&fileError];
    
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
