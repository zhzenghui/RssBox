//
//  DRitemRecords.m
//  DouBanRss
//
//  Created by dong xin on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DRitemRecords.h"

#import <CFNetwork/CFNetwork.h>
#import "ItemInfo.h"

static NSString *const rssFeed = @"http://www.douban.com/feed/review/latest";

@implementation DRitemRecords

@synthesize recordsDeletage;
@synthesize workingEntry;

@synthesize itemRecords;
@synthesize queue;

- (id)init:(NSString *)urlRssFeed delegate:(id)delegate{
    
    self = [super init];
    if (self) {
        
        self.recordsDeletage = delegate;
        self.itemRecords = [[NSMutableArray alloc] init];
        
        DRConnection *drconnection = [[DRConnection alloc] init];
        [drconnection connection:urlRssFeed delegate:self];
        [drconnection release];

    }
    return self;
}

- (void)dealloc {
    
    [workingEntry release];
    [itemRecords release];
    [queue release];
    [super dealloc];
}
// -------------------------------------------------------------------------------
//	handleLoadedApps:notif
// -------------------------------------------------------------------------------
- (void)handleLoadedApps:(NSArray *)loadedApps
{
    
    [self.itemRecords addObjectsFromArray:loadedApps];
    [self.itemRecords removeObjectAtIndex:0];
    // tell our table view to reload its data, now that parsing has completed
    
    //回调
    
    [recordsDeletage records:self.itemRecords];
}

// -------------------------------------------------------------------------------
//	didFinishParsing:appList
// -------------------------------------------------------------------------------
- (void)didFinishParsing:(NSArray *)appList
{
    [self performSelectorOnMainThread:@selector(handleLoadedApps:) withObject:appList waitUntilDone:NO];
    
    self.queue = nil;   // we are finished with the queue and our ParseOperation
}

- (void)parseErrorOccurred:(NSError *)error
{
    [self performSelectorOnMainThread:@selector(handleError:) withObject:error waitUntilDone:NO];
}

// -------------------------------------------------------------------------------
//	handleError:error
// -------------------------------------------------------------------------------
- (void)handleError:(NSError *)error
{
    
    [recordsDeletage recordError:error];
    
}

#pragma mark - DRConnectionDelegate 

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [self handleError:error];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection : (NSMutableData *)data{
    
    // create the queue to run our ParseOperation
    self.queue = [[[NSOperationQueue alloc] init] autorelease];
    
    // create an ParseOperation (NSOperation subclass) to parse the RSS feed data so that the UI is not blocked
    // "ownership of appListData has been transferred to the parse operation and should no longer be
    // referenced in this thread.
    //
    ParseOperation *parser = [[ParseOperation alloc] initWithData:data delegate:self];
    
    [queue addOperation:parser]; // this will start the "ParseOperation"
    
    [parser release];
    
    // ownership of appListData has been transferred to the parse operation
    // and should no longer be referenced in this thread
    data = nil;
    
}



@end
