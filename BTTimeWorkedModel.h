//
//  BTTimeWorkedModel.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 3/2/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

/// @class BTTimeWorkedModel
/// @brief Model to control how much time has been used working.

#import <Cocoa/Cocoa.h>


@interface BTTimeWorkedModel : NSObject {

}

/// @brief Return the amount of work done on a given calendar day.
- (NSTimeInterval)timeWorkedOnDate:(NSDate*)aDate;

/// @brief Add a time interval to the proper day.
- (void)addTimeInterval:(NSTimeInterval) startingOnDate:(NSDate*)aDate;

@end
