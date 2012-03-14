//
//  DRitemRecords.h
//  DouBanRss
//
//  Created by dong xin on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DRConnection.h"
#import "ParseOperation.h"

@protocol DRitemRecordsDelegate <NSObject>

- (void)records:(NSMutableArray *)itemInfo;

- (void)recordError:(NSError *)error;

@end

@interface DRitemRecords : NSObject <DRConnectionDelegate, ParseOperationDelegate>  {
    
    
    ItemInfo       *workingEntry;
    
    // the list of apps shared with "RootViewController"
    NSMutableArray          *itemRecords;
    
    // the queue to run our "ParseOperation"
    NSOperationQueue		*queue;
    
    id<DRitemRecordsDelegate> recordsDeletage;
}

@property (nonatomic, retain) ItemInfo *workingEntry;
@property (nonatomic, retain) NSMutableArray *itemRecords;
@property (nonatomic, retain) NSOperationQueue *queue;

@property (nonatomic, retain) id<DRitemRecordsDelegate> recordsDeletage;


- (id)init:(NSString *)urlRssFeed delegate:(id)delegate;
    
@end
