//
//  14HostsController.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/8/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "FTHostsController.h"


@implementation FTHostsController

- (id)init {
    self = [super init];
    if ( self ) {
        uniqueName = [[NSString alloc] initWithString:@"HostsController"];
    }
    return self;
}

- (void)dealloc {
    [uniqueName release];
    [super dealloc];
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


- (void)writeHosts {
    
}


- (void)addHostWithName:(NSString*)aName ip:(NSString*)ip {
    
}


@end
