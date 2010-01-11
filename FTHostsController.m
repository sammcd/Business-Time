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
    NSMutableString*    hostsFile;
    NSString*           sectionStart;
    NSString*           sectionEnd;
    
    sectionStart = [NSString stringWithFormat:@"# %@ START",uniqueName];
    sectionEnd = [NSString stringWithFormat:@"# %@ END",uniqueName];
    
    // Open file
    hostsFile = [[NSMutableString alloc] initWithString:[self readHostsFile]];
    
    
    NSMutableString* newHosts = [[NSMutableString alloc] initWithCapacity:[hosts count] * 25];
    for (FTHost* host in hosts) {
        [newHosts appendString:[NSString stringWithFormat:@"%@ %@\n", host.ip, host.name]];
    } 

    // Check if we have already talked to this file.
    NSRange startRange = [hostsFile rangeOfString:sectionStart];  
    
    if ( startRange.location == NSNotFound ) {
        // Did not find the section so create it.

        [hostsFile appendString:[NSString stringWithFormat:@"%@\n",sectionStart]];
        [hostsFile appendString:newHosts];
        [hostsFile appendString:[NSString stringWithFormat:@"%@\n",sectionEnd]];

    } else {
        // We did find the section, so update it.
        NSLog(@"Update");
        NSRange rangeToDelete;
        rangeToDelete.location = startRange.location + startRange.length; // end of first line
        
        NSRange endRange = [hostsFile rangeOfString:sectionEnd];
        if ( endRange.location == NSNotFound ) {
            // Okay so the stupid user messed up my pretty little file.
            // Time for some major repair!!
            // todo: handle gracefully, right now we just delete it all
            
            rangeToDelete.length = [hostsFile length] - rangeToDelete.location - 1;
            
        } else {
            rangeToDelete.length = endRange.location - startRange.location - 1;
            NSLog(@"%d - %d = %d",endRange.location, startRange.location,rangeToDelete.length);

        }
        
        NSLog(@"%d %d %d",rangeToDelete.location, rangeToDelete.length, [hostsFile length]);
        
        if ( rangeToDelete.length > [sectionStart length] ) 
            [hostsFile deleteCharactersInRange:rangeToDelete];
        
        [hostsFile insertString:@"\n" atIndex:rangeToDelete.location];
        [hostsFile insertString:newHosts atIndex:rangeToDelete.location+1];
        [hostsFile insertString:@"\n" atIndex:rangeToDelete.location ];
        [hostsFile insertString:sectionEnd atIndex:rangeToDelete.location ];
                
    }
    

    NSError* error;
    [hostsFile writeToFile:@"/Users/sammcd/Desktop/hosts" atomically:YES encoding:NSASCIIStringEncoding error:&error];

    
    // Flush dns caches 

    [hostsFile release];
    [newHosts release];
}

- (void)removeHostsFromFile {
    NSMutableString*     hostsFile;
    NSString*           sectionStart;
    NSString*           sectionEnd;
    
    sectionStart = [NSString stringWithFormat:@"# %@ START",uniqueName];
    sectionEnd = [NSString stringWithFormat:@"# %@ END",uniqueName];
    
    // Open file
    hostsFile = [[NSMutableString alloc] initWithString:[self readHostsFile]];
    
    // Find section
    // Check if we have already talked to this file.
    NSRange startRange = [hostsFile rangeOfString:sectionStart];  
    
    if ( startRange.location == NSNotFound ) {
        // Did not find the section so do nothing.
        
    } else {
        // We did find the section, so update it.
        NSLog(@"Update");
        NSRange rangeToDelete;
        rangeToDelete.location = startRange.location + startRange.length; // end of first line
        
        NSRange endRange = [hostsFile rangeOfString:sectionEnd];
        if ( endRange.location == NSNotFound ) {
            // Okay so the stupid user messed up my pretty little file.
            // Time for some major repair!!
            // todo: handle gracefully, right now we just delete it all
            
            rangeToDelete.length = [hostsFile length] - rangeToDelete.location -1;
            
        } else {
            rangeToDelete.length = endRange.location - startRange.location - 1;
            NSLog(@"%d - %d = %d",endRange.location, startRange.location,rangeToDelete.length);
            
        }
        
        NSLog(@"%d %d %d",rangeToDelete.location, rangeToDelete.length, [hostsFile length]);
        
        NSLog(@"%@",hostsFile);
        if ( rangeToDelete.length > [sectionStart length] ) 
            [hostsFile deleteCharactersInRange:rangeToDelete];
        NSLog(@"===================================");
        NSLog(@"%@",hostsFile);
        //NSLog(@"length: %d index: %d",[hostsFile length];
        [hostsFile insertString:@"\n" atIndex:rangeToDelete.location ];
        [hostsFile insertString:sectionEnd atIndex:rangeToDelete.location+1];
        
    }
    
    NSLog(@"Tried to delete");
    
    NSError* error;
    [hostsFile writeToFile:@"/Users/sammcd/Desktop/hosts" atomically:YES encoding:NSASCIIStringEncoding error:&error];
    
    // Flush DNS caches
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
