//
//  DRMethodUtility.h
//  DouBanRss
//
//  Created by dong xin on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRMethodUtility : NSObject


- (NSString *)doubanPcUrlTomUrl :(NSString *)url;

+ (NSString *)getTodayDate;

+ (NSString *) dateNSDateFormatterShortStyle;

@end
