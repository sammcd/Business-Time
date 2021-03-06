//
//  FTHostsController.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/8/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "FTHostsController.h"
#import "FTHost.h"
#import "NSFileManagerAdditions.h"
#import <Security/Security.h>
#import <SecurityFoundation/SFAuthorization.h>


@implementation FTHostsController

#pragma mark Overriding NSObject
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
    [hosts release];
    [super dealloc];
}


#pragma mark Class Methods
+ (void)flushDNS {
    // A poor man's dns flush.
    NSArray* arguments = [NSArray arrayWithObjects:@"-flushcache",nil];
    [NSTask launchedTaskWithLaunchPath:@"/usr/bin/dscacheutil" arguments:arguments];
}

#pragma mark Write Hosts to Path
- (NSString*)hostsFilePath {
    return [NSString stringWithContentsOfFile:@"/etc/hosts" encoding:NSASCIIStringEncoding error:NULL];
}

- (void)writeArrayToHosts:(NSArray*)arrayToWrite {
    NSString*           sectionStart;
    NSString*           sectionEnd;
    NSString*           hostsString;
    NSMutableArray*     hostsArray;
    NSMutableArray*     addedContent;
    int                 startLine  = -1;
    int                 stopLine = -1;
    int                 indexToAdd = 0;
    
    hostsArray = [[NSMutableArray alloc] initWithArray:[[self hostsFilePath] componentsSeparatedByString:@"\n"]];
    addedContent = [[NSMutableArray alloc] init];
    
    sectionStart = [NSString stringWithFormat:@"# %@ START",uniqueName];
    sectionEnd = [NSString stringWithFormat:@"# %@ END",uniqueName];
    
    
    // Loop through the array looking for the line end and beginning.
    int i;
    NSLog(@"%d host count",[hostsArray count]);
    for (i = 0; i < [hostsArray count]; i++ ) {
        NSString* line = [hostsArray objectAtIndex:i];
        
        NSLog(@"Line: %@",line);
        NSLog(@"Suffix: %@",sectionStart);
        
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
    
    NSLog(@"start: %d stop: %d",startLine,stopLine); 
    
    
    if ( startLine == -1 ) {
        NSLog(@" there is no section");
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
        NSLog(@"Remove Range: %d %d",removeRange.location, removeRange.length);
        
    }
    
    // Let create the array of lines that 
    // Should be in the middle
    for ( FTHost* host in arrayToWrite ) {
        [addedContent addObject:[NSString stringWithFormat:@"%@ %@",host.ip, host.name]];
    }
    
    // Bring array back to string.
    NSRange beforeNewContent;
    beforeNewContent.location = 0;
    beforeNewContent.length = indexToAdd;
    NSRange afterNewContent;
    afterNewContent.location = indexToAdd;
    afterNewContent.length = [hostsArray count] - indexToAdd;
    
    // Create strings for before the content, the content, and after the content. Then Combine them
    NSString* beginingString = [[hostsArray subarrayWithRange:beforeNewContent] componentsJoinedByString:@"\n"];
    NSString* stringWithContent = [addedContent componentsJoinedByString:@"\n"];
    NSString* endingString = [[hostsArray subarrayWithRange:afterNewContent] componentsJoinedByString:@"\n"];
    hostsString = [NSString stringWithFormat:@"%@\n%@\n%@",beginingString,stringWithContent,endingString]; 
    
    
    NSError* fileError;
    NSString* tmpPath = [[NSFileManager defaultManager] newTmpFilePath];
    [hostsString writeToFile:tmpPath atomically:YES encoding:NSASCIIStringEncoding error:&fileError];
    [[NSFileManager defaultManager] authorizedMovePath:tmpPath toPath:@"/etc/hosts"];
    [hostsArray release];
    [addedContent release];
    
}

- (void)writeHostsToFile {
    [self writeArrayToHosts:hosts];
}

- (void)removeHostsFromFile {
    [self writeArrayToHosts:[NSArray array]];
    
}

#pragma mark Changing Name
- (void)setUniqueName:(NSString*)aName {
    NSString* oldName = uniqueName;
    uniqueName = [[NSString alloc] initWithString:aName];
    [oldName release];
}


#pragma mark Adding Hosts
- (void)addHostWithName:(NSString*)aName ip:(NSString*)ip {
    BOOL updated = NO;
    
    for ( FTHost* host in hosts ) {
        if ( [host.name isEqualToString:aName] ) {
            host.ip = ip;
            updated = YES;
        }
    }
    
    if ( !updated ) {
        FTHost* aHost = [[FTHost alloc] init];
        aHost.name = aName;
        aHost.ip = ip;
        
        [hosts addObject:aHost];  
        [aHost release];
    }
}


@end
