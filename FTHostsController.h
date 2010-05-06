//
//  FTHostsController.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/8/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

/// @class FTHostsController
/// Class to write new records to /etc/hosts
/// Depends on NSFileManagerAdditions.

#import <Cocoa/Cocoa.h>

@interface FTHostsController : NSObject {
    NSString*       uniqueName;
    NSMutableArray* hosts;
    
}

/// @brief Calls dscacheutil -flushcache To allow new hosts to set. 
+ (void)flushDNS;


/// @return Returns the path to the hosts file.
- (NSString*)hostsFilePath;

/// @brief Write hosts to /etc/hosts.
- (void)writeHostsToFile;

/// @brief Remove our hosts section from /etc/hosts
- (void)removeHostsFromFile;


/// @brief This is the unique name that will identify your apps section of the hosts file defaults to 'HostsController'
- (void)setUniqueName:(NSString*)aName;

/// @brief Add a host to the list.
- (void)addHostWithName:(NSString*)aName ip:(NSString*)ip;


@end
