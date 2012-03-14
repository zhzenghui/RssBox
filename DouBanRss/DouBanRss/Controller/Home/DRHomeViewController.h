//
//  DRHomeViewController.h
//  DouBanRss
//
//  Created by dong xin on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ZYIDownloader.h"

@interface DRHomeViewController : UITableViewController <UIActionSheetDelegate, ZYIDownloaderDelegate>
{
    
    ASIHTTPRequest *request;
    
    NSMutableArray          *settingRecords;
    NSMutableDictionary       *entryRss;    
    NSMutableArray          *entryRssRecords;
    
        NSMutableDictionary *imageDownloadsInProgress; 
    
}

@property (nonatomic, retain) ASIHTTPRequest *request;

@property (nonatomic, retain) NSMutableDictionary       *entryRss;
@property (nonatomic, retain) NSMutableArray          *entryRssRecords;
@property (nonatomic, retain) NSMutableArray    *settingRecords;

@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;

- (void)appImageDidLoad:(NSIndexPath *)indexPath;
@end
