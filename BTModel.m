//
//  BTModel.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/8/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "BTModel.h"
#import "BTBlackListModel.h"

static BTModel *sharedModel = nil;


@implementation BTModel

#pragma mark Overriding NSObject
- (id)init {
    self = [super init];
    if ( self ) {
        blackListModel = [[BTBlackListModel alloc] init];
    }
    return self;
}

- (void)dealloc {
    [blackListModel release];
    [super dealloc];
}

#pragma mark Archiving
- (id)initWithCoder:(NSCoder*)coder {
    if ( sharedModel == nil ) {
        [BTModel  sharedModel];
    }
    
    // Set values equal to the coder
    if ( blackListModel != nil ) {
        [blackListModel release];
    }
    
    blackListModel = [[coder decodeObjectForKey:@"BTMBlackList"] retain];
    
    return sharedModel;
}

- (void)encodeWithCoder:(NSCoder*)coder {
    
    [coder encodeObject:blackListModel forKey:@"BTMBlackList"];
    [coder encodeObject:@"0.1"  forKey:@"BTMVersion"];
}

#pragma mark Accessing Black List
- (BTBlackListModel*)blackListModel {
    return blackListModel;
}




// --- Singelton Code
#pragma mark Singelton Support
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
