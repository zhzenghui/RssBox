//
//  ItemInfo.m
//  DouBanRss
//
//  Created by dong xin on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ItemInfo.h"


@implementation ItemInfo

@synthesize title;
@synthesize link;
@synthesize description;
@synthesize content_encoded;

@synthesize dc_creator;
@synthesize pubDate;
@synthesize guid;

- (void)dealloc {
    
    [title release];
    [link release];
    [description release];
    [content_encoded release];
    
    [dc_creator release];
    [pubDate release];
    [guid release];
    
    [super dealloc];
}
@end
