//
//  FTHost.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/8/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

/// @class FTHost
/// @brief Object representing a record in /etc/hosts

#import <Cocoa/Cocoa.h>


@interface FTHost : NSObject {
    NSString*      name;
    NSString*      ip;
    
}

@property (retain, nonatomic) NSString* name;
@property (retain, nonatomic) NSString* ip;

@end
