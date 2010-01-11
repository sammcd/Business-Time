//
//  BTBlackListModel.h
//  BusinessTime
//
//  Created by Sam Mcdonald on 1/8/10.
//  Copyright 2010 141312 LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class FTHostsController;

@interface BTBlackListModel : NSObject {
    NSMutableArray*     siteList;
    FTHostsController*  hostsController;
    
}

- (NSMutableArray*)siteList; 
- (void)addSite:(NSString*)aSite;
- (void)removeSite:(NSString*)aSite;
- (NSInteger)count;

- (void)enableFilters;
- (void)disableFilters;

@end
