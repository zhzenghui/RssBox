//
//  ZYIDownloader.m
//  ZYSharePoint
//
//  Created by Zeng on 12-1-14.
//  Copyright (c) 2012年 山西振业. All rights reserved.
//

#import "ZYIDownloader.h"
#import "DRXmlToArr.h"

#define kAppIconHeight 48


@implementation ZYIDownloader

@synthesize appRecord;
@synthesize indexPathInTableView;
@synthesize delegate;
@synthesize activeDownload;
@synthesize imageConnection;

#pragma mark

- (void)dealloc
{
    [appRecord release];
    [indexPathInTableView release];
    
    [activeDownload release];
    
    [imageConnection cancel];
    [imageConnection release];
    
    [super dealloc];
}

- (void)startDownload :(NSString *)urlString :(NSString *)xmlString :(NSString *)SOAPAction{
    
    NSString *soapAction = [NSString stringWithFormat:@"%@", SOAPAction];
    NSString *soapMessage = [NSString stringWithFormat:@"%@", xmlString];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: soapAction forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection  *conn = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( conn )
    {
        self.activeDownload = [[NSMutableData data] retain];
    }
    else
    {
        NSLog(@"theConnection is NULL");
    }
}

- (void)cancelDownload
{
    [self.imageConnection cancel];
    self.imageConnection = nil;
    self.activeDownload = nil;
}


#pragma mark -
#pragma mark Download support (NSURLConnectionDelegate)

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.activeDownload appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	// Clear the activeDownload property to allow later attempts
    self.activeDownload = nil;
    
    // Release the connection now that it's finished
    self.imageConnection = nil;
}

- (void) dataToCount :(NSData *)theData {
    
        if (!([theData length] == 0)) {
            
            NSString *str = [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
            NSLog(@"%@", str);
            [str release];
            
//            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[ZYXmlResolve getXmlToArr:theData :@"GetListItemsResult"  :@"z:row"]];
//            
//            NSString *s =[NSString stringWithFormat:@"%d", [array count]];
//            
//            [self.appRecord setValue:s forKey:@"countNum"];
//
//            [array release];

        }
        
        [theData release];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Set appIcon and clear temporary data/image
//    UIImage *image = [[UIImage alloc] initWithData:self.activeDownload];
//    
//    if (image.size.width != kAppIconHeight && image.size.height != kAppIconHeight)
//	{
//        CGSize itemSize = CGSizeMake(kAppIconHeight, kAppIconHeight);
//		UIGraphicsBeginImageContext(itemSize);
//		CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
//		[image drawInRect:imageRect];
////		[self.appRecord objectForKey:@""] = UIGraphicsGetImageFromCurrentImageContext();
//        
//		UIGraphicsEndImageContext();
//    }
//    else
//    {
//        self.appRecord.appIcon = image;
//    }
    [self dataToCount:self.activeDownload];
    
    self.activeDownload = nil;
//    [image release];
    
    // Release the connection now that it's finished
    self.imageConnection = nil;
    
    // call our delegate and tell it that our icon is ready for display
    [delegate appImageDidLoad:self.indexPathInTableView];
}

@end