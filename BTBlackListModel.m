//
//  BTBlackListModel.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/8/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "BTBlackListModel.h"
#import "FTHostsController.h"


@implementation BTBlackListModel

- (id)init {
    self = [super init];
    if (self) {
        siteList = [[NSMutableArray alloc] init];
        hostsController = [[FTHostsController alloc] init];
        [hostsController setUniqueName:@"BusinessTime"];
    }
    return self;
}

- (void)dealloc {
    [siteList release];
    [hostsController release];
    [super dealloc];
}

- (id)initWithCoder:(NSCoder*)coder {
    self = [super init];
    if ( self) {
        siteList = [[coder decodeObjectForKey:@"BTBSiteList"] retain];
        hostsController = [[FTHostsController alloc] init];
        [hostsController setUniqueName:@"BusinessTime"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)coder {
    [coder encodeObject:siteList forKey:@"BTBSiteList"];
    
}


- (NSMutableArray*)siteList {
    return siteList;
}

- (void)addSite:(NSString*)aSite {
    [siteList addObject:aSite];
}

- (void)removeSite:(NSString*)aSite {
    [siteList removeObject:aSite];
}

- (NSInteger)count {
    return [siteList count];
}


- (void)enableFilters {

    for ( NSString* site in siteList ) {
        [hostsController addHostWithName:site ip:@"127.0.0.1"];
    }
    [hostsController writeHostsToFile];   
    [FTHostsController flushDNS];
}

- (void)disableFilters {
    [hostsController removeHostsFromFile];
    [FTHostsController flushDNS];
}


@end
