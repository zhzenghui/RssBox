//
//  DRBookViewController.h
//  DouBanRss
//
//  Created by dong xin on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRitemRecords.h"
#import "ItemInfo.h"

@interface DRBookViewController : UITableViewController <DRitemRecordsDelegate>  {
    
    
    ItemInfo       *workingEntry;
    
    NSMutableArray          *itemRecords;
    
}

@property (nonatomic, retain) ItemInfo *workingEntry;
@property (nonatomic, retain) NSMutableArray *itemRecords;


@end
