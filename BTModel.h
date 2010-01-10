//
//  BTModel.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/8/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class BTBlackListModel;


@interface BTModel : NSObject {
    BTBlackListModel*   blackListModel;
}

/// Return the shared model
+ (BTModel*)sharedModel;

/// @return The black list model
- (BTBlackListModel*)blackListModel;


@end
