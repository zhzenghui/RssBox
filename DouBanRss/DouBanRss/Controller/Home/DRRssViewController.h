//
//  DRRssViewController.h
//  DouBanRss
//
//  Created by dong xin on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "AppRecord.h"

@interface DRRssViewController : UITableViewController   {
    
    
    NSString *rssLink ;

    NSMutableDictionary       *rssRecord;
    
    // the list of apps shared with "RootViewController"
    NSMutableArray          *itemRecords;
    
    
    ASIHTTPRequest *request;
}

@property (nonatomic, retain) NSString *rssLink;

@property (nonatomic, retain) NSMutableDictionary *rssRecord;
@property (nonatomic, retain) NSMutableArray *itemRecords;
@property (nonatomic, retain) ASIHTTPRequest *request;


@end
