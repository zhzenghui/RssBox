//
//  DRConnection.m
//  DouBanRss
//
//  Created by dong xin on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DRConnection.h"

@implementation DRConnection

@synthesize appListFeedConnection;
@synthesize appListData;
@synthesize delegate;

- (void)dealloc {
    
    [appListData release];
    [appListFeedConnection release];
    
    [super dealloc];
}

- (void)connection:(NSString *)urlString  delegate:(id)connectionDelegate
{

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
    self.delegate = connectionDelegate;
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    self.appListFeedConnection = [[[NSURLConnection alloc] initWithRequest:urlRequest delegate:self] autorelease];
    
    NSAssert(self.appListFeedConnection != nil, @"Failure to create URL connection.");
    
    // show in the status bar that network activity is starting
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// -------------------------------------------------------------------------------
//	connection:didReceiveResponse:response
// -------------------------------------------------------------------------------
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.appListData = [NSMutableData data];    // start off with new data
}

// -------------------------------------------------------------------------------
//	connection:didReceiveData:data
// -------------------------------------------------------------------------------
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [appListData appendData:data];  // append incoming data
}

// -------------------------------------------------------------------------------
//	connection:didFailWithError:error
// -------------------------------------------------------------------------------
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    

    
    if ([error code] == kCFURLErrorNotConnectedToInternet)
	{
        // if we can identify the error, we can present a more precise message to the user.
//        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"No Connection Error"
//															 forKey:NSLocalizedDescriptionKey];
//        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
//														 code:kCFURLErrorNotConnectedToInternet
//													 userInfo:userInfo];
//        [self handleError:noConnectionError];
        [delegate connection:connection didFailWithError:error];
    }
	else
	{
        // otherwise handle the error generically
//        [self handleError:error];
    }
    
    self.appListFeedConnection = nil;   // release our connection
}

// -------------------------------------------------------------------------------
//	connectionDidFinishLoading:connection
// -------------------------------------------------------------------------------
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.appListFeedConnection = nil;   // release our connection
//    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;   
    
    
    [delegate connectionDidFinishLoading:connection :appListData];
//    
//    // create the queue to run our ParseOperation
//    self.queue = [[NSOperationQueue alloc] init];
//    
//    // create an ParseOperation (NSOperation subclass) to parse the RSS feed data so that the UI is not blocked
//    // "ownership of appListData has been transferred to the parse operation and should no longer be
//    // referenced in this thread.
//    //
//    ParseOperation *parser = [[ParseOperation alloc] initWithData:appListData delegate:self];
//    
//    [queue addOperation:parser]; // this will start the "ParseOperation"
//    
//    [parser release];
//    
//    // ownership of appListData has been transferred to the parse operation
//    // and should no longer be referenced in this thread
//    self.appListData = nil;
}


@end
