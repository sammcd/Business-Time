//
//  BTTimeInterval.m
//  BusinessTime
//
//  Created by Sam Mcdonald on 3/2/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import "BTTimeInterval.h"


@implementation BTTimeInterval

@synthesize startDate;
@synthesize stopDate;

#pragma mark Inititializing and deallocing.
- (id)init {
    self = [super init];
    if ( self ) {
        
    }
    return self;
}

- (id)initWithStartDate:(NSDate*)firstDate endDate:(NSDate*)secondDate {
    self = [self init];
    if ( self ) {
        [self setStartDate:firstDate];
        [self setStopDate:secondDate];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

@end
