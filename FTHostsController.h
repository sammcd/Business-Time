//
//  FTHostsController.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/8/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FTHostsController : NSObject {
    NSString*       uniqueName;
    NSMutableArray* hosts;
    
}

+ (void)flushDNS;
- (void)writeHostsToFile;
- (void)removeHostsFromFile;

/// This is the unique name that will identify your apps section of the hosts file defaults to 'HostsController'
- (void)setUniqueName:(NSString*)aName;

/// Add a host to the list.
- (void)addHostWithName:(NSString*)aName ip:(NSString*)ip;

- (NSString*)readHostsFile;

@end
