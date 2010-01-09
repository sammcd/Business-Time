//
//  BTModel.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/8/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "BTModel.h"
#import "BTBlackListModel.h"


@implementation BTModel

- (id)init {
    self = [super init];
    if ( self ) {
        blackListModel = [[BTBlackListModel alloc] init];
    }
    return self;
}

- (BTBlackListModel*)blackListModel {
    return blackListModel;
}


- (void)dealloc {
    [blackListModel release];
    [super dealloc];
}

//////////////////////////
// Singelton Code
//////////////////////////
static BTModel *sharedModel = nil;

+ (BTModel*)sharedModel
{
    @synchronized(self) {
        if (sharedModel == nil) {
            [[self alloc] init]; // assignment not done here
        }
    }
    return sharedModel;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedModel == nil) {
            sharedModel = [super allocWithZone:zone];
            return sharedModel;  // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return UINT_MAX;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}


@end
