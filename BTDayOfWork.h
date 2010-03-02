//
//  BTDayOfWork.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 3/2/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

/// @class BTDayOfWork
/// @brief A class that represents a day of work (aka BTTimeInterval)

#import <Cocoa/Cocoa.h>


@interface BTDayOfWork : NSObject {

}


- (NSTimeInterval)timeWorked;
- (float)hoursWorked;

@end
