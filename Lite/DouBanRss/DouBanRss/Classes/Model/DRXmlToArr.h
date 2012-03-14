//
//  DRXmlToArr.h
//  DouBanRss
//
//  Created by dong xin on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBXML.h"
#import "NSDataAdditions.h"

@interface DRXmlToArr : NSObject



+ (void)allElemData:(TBXMLElement *)element:(NSString *)tName;
+ (void)allElementData:(TBXMLElement *)element:(NSString *)tName;
//
+ (NSMutableArray *)getElementToArr:(NSData *)data:(NSString *)tName;

+ (void)allXmlAttributeData:(TBXMLElement *)element:(NSString *)tName;
+ (void)allXmlElementData:(TBXMLElement *)element:(NSString *)sListName:(NSString *)tName;
+ (NSMutableArray *)getXmlToArr:(NSData *)data:(NSString *)dataRowName:(NSString *)GetResultFiled;

+ (void)allAttributeData:(TBXMLElement *)element:(NSString *)tName;
+ (NSMutableArray *)getAttributeToArr:(NSData *)data:(NSString *)tName;



@end
