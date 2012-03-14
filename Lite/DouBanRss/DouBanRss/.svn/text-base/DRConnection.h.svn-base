//
//  DRConnection.h
//  DouBanRss
//
//  Created by dong xin on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DRConnectionDelegate <NSObject>

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection : (NSMutableData *)data;


@end


@interface DRConnection : NSObject {
    
    // RSS feed network connection to the App Store
    NSURLConnection         *appListFeedConnection;
    NSMutableData           *appListData;
    
    id<DRConnectionDelegate> delegate;
}

@property( nonatomic, retain) id<DRConnectionDelegate> delegate;

@property (nonatomic, retain) NSURLConnection *appListFeedConnection;
@property (nonatomic, retain) NSMutableData *appListData;


- (void)connection:(NSString *)urlString  delegate:(id)connectionDelegate;

@end
