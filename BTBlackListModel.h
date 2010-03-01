//
//  BTBlackListModel.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/8/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//


/// @class BTBlackListModel
/// @brief Class to represent a blacklist of websites.

#import <Cocoa/Cocoa.h>
@class FTHostsController;

@interface BTBlackListModel : NSObject {
    NSMutableArray*     siteList;
    FTHostsController*  hostsController;
    
}

/// @brief Get the list of banned sites.
/// @return Returns an array of websites represented as strings
- (NSMutableArray*)siteList; 

/// @brief Add a website to the ban list
- (void)addSite:(NSString*)aSite;

/// @brief Remove a website from the ban list.
- (void)removeSite:(NSString*)aSite;

/// @return Returns number of site on the ban list.
- (NSInteger)count;

/// @brief Enables filtering via ban list.
- (void)enableFilters;

/// @brief Disables filtering via ban list.
- (void)disableFilters;

@end
