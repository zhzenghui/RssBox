//
//  DRGdataXmlToArr.h
//  RssBox
//
//  Created by dong xin on 12-3-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"


@interface DRGdataXmlToArr : NSObject

+ (NSMutableArray *)getElementToArr1:(NSData *)data:(NSString *)tName;

@end
