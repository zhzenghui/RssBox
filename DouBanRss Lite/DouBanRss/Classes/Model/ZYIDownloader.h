//
//  ZYIDownloader.h
//  ZYSharePoint
//
//  Created by Zeng on 12-1-14.
//  Copyright (c) 2012年 山西振业. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYIDownloader.h"

@protocol ZYIDownloaderDelegate;

@interface ZYIDownloader : NSObject
{
    NSDictionary *appRecord;
    NSIndexPath *indexPathInTableView;
    id <ZYIDownloaderDelegate> delegate;
    
    NSMutableData *activeDownload;
    NSURLConnection *imageConnection;
}

@property (nonatomic, retain) NSDictionary *appRecord;
@property (nonatomic, retain) NSIndexPath *indexPathInTableView;
@property (nonatomic, assign) id <ZYIDownloaderDelegate> delegate;

@property (nonatomic, retain) NSMutableData *activeDownload;
@property (nonatomic, retain) NSURLConnection *imageConnection;

- (void)startDownload:(NSString *)urlString :(NSString *)xmlString :(NSString *)SOAPAction;
- (void)cancelDownload;

@end

@protocol ZYIDownloaderDelegate 

- (void)appImageDidLoad:(NSIndexPath *)indexPath;

@end

