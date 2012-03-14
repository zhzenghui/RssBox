//
//  ChannelInfo.m
//  DouBanRss
//
//  Created by dong xin on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChannelInfo.h"

@implementation ChannelInfo

@synthesize title;
@synthesize link;
@synthesize description;
@synthesize language;
@synthesize copyright;
@synthesize pubDate;

- (void)dealloc {
    
    [title release];
    [link release];
    [description release];
    [language release];
    
    [copyright release];
    [pubDate release];
    
    [super dealloc];
}
@end
