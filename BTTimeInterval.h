//
//  BTTimeInterval.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 3/2/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

/// @class BTTimeInterval
/// @brief Used for intervals of time worked.

#import <Cocoa/Cocoa.h>


@interface BTTimeInterval : NSObject {
    NSDate*     startDate;
    NSDate*     stopDate;
    
}

@property (nonatomic,retain) NSDate* startDate;
@property (nonatomic,retain) NSDate* stopDate;

/// @brief Initialize with undefined start and stop date.
- (id)init;

/// @brief Initialize setting start and stop date.
- (id)initWithStartDate:(NSDate*)firstDate endDate:(NSDate*)secondDate;


@end
