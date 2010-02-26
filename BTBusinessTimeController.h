//
//  BTBusinessTimeController.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 2/9/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class BTStatusWindowController;

@interface BTBusinessTimeController : NSObject {
    BTStatusWindowController* statusWindowController;
    
    BOOL isBusinessTime;
}


- (void)startBusinessTime;
- (void)stopBusinessTime;
- (void)toggleBusinessTime;

- (BOOL)isBusinessTime;


@end
