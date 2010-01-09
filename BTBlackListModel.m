//
//  BTBlackListModel.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/8/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "BTBlackListModel.h"


@implementation BTBlackListModel

- (id)init {
    self = [super init];
    if (self) {
        siteList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [siteList release];
    [super dealloc];
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


@end
