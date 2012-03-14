//
//  DRMethodUtility.m
//  DouBanRss
//
//  Created by dong xin on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DRMethodUtility.h"

@implementation DRMethodUtility


- (NSString *)doubanPcUrlTomUrl :(NSString *)url{
    
    //    http://m.douban.com/movie/subject/2028677/?session=77c56dca
    //    http://movie.douban.com/subject/2028677/
    
    NSString *pcUrl = [NSString stringWithFormat:url];
    
    
    
    return pcUrl;
}


+ (NSString *)getTodayDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy"];
    int year = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    
    [dateFormatter setDateFormat:@"MM"];
    int month = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    
    [dateFormatter setDateFormat:@"dd"];
    int day = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    
//    [dateFormatter setDateFormat:@"HH"];
//    int hour = [[dateFormatter stringFromDate:[NSDate date]] intValue];
//    
//    [dateFormatter setDateFormat:@"mm"];
//    int minute = [[dateFormatter stringFromDate:[NSDate date]] intValue];
//    
//    [dateFormatter setDateFormat:@"ss"];
//    int second = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    
    [dateFormatter release];

    return [NSString stringWithFormat:@"%d-%d-%d", year, month, day];
}


+ (NSString *) dateNSDateFormatterShortStyle {
    
    NSDate *now = [NSDate date];
	NSDateFormatter *formatter = nil;
	formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setTimeStyle:NSDateFormatterFullStyle];
	return  [formatter stringFromDate:now];
}
@end
