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

#pragma mark Overriding NSObject
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

#pragma mark Archiving
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

#pragma mark Managing Site List
- (NSMutableArray*)siteList {
    return siteList;
}

- (void)addSite:(NSString*)aSite {
    [siteList addObject:aSite];
}

- (void)removeSite:(NSString*)aSite {
    for (NSString* aString in siteList) {
        if ( [aString caseInsensitiveCompare:aSite] ) {
            [siteList removeObject:aString];
        }
    }
}

- (NSInteger)count {
    return [siteList count];
}


#pragma mark Enabling/Disabling Filter
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
