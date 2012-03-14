//
//  DRXmlToArr.m
//  DouBanRss
//
//  Created by dong xin on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DRXmlToArr.h"

static NSMutableArray *dataArr;

@implementation DRXmlToArr

+ (void)allElemData:(TBXMLElement *)element:(NSString *)tName{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    do {
        
        NSLog(@"%@,%@", [TBXML elementName:element],  [TBXML textForElement:element]);
        [dict setObject:[TBXML textForElement:element] forKey:[TBXML elementName:element]];
        
        //递归处理子树
        if (element->firstChild) {
            [self allElemData:element->firstChild:tName];
        }
        //迭代处理兄弟树
    } while ((element = element->nextSibling));
    
    if (![[dict objectForKey:tName]isEqual:@""]) {
        [dataArr addObject:dict];
    }
    [dict release];
    
}

+ (void)allElementData:(TBXMLElement *)element:(NSString *)tName{
    do {
        if ([[TBXML elementName:element] isEqualToString:tName]) {;
            [self allElemData:element:tName];
            break;
        }
        //递归处理子树
        if (element->firstChild) {
            [self allElementData:element->firstChild:tName];
        }
        //迭代处理兄弟树
    } while ((element = element->nextSibling));
}

+ (NSMutableArray *)getElementToArr:(NSData *)data:(NSString *)tName{
    dataArr = [[[NSMutableArray alloc] init] autorelease];
    
    TBXML * tbxml = [[TBXML alloc] initWithXMLData:data];
    
    [self allElementData:tbxml.rootXMLElement:tName];
    
    [tbxml release];
    return dataArr;
}


+ (void)allXmlAttributeData:(TBXMLElement *)element:(NSString *)tName{
    do {
        if ([[TBXML elementName:element] isEqualToString:tName]) {
            
            TBXMLAttribute * attribute = element->firstAttribute;              
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            while (attribute) {
                
                [dict setObject:[TBXML attributeValue:attribute] forKey:[TBXML attributeName:attribute]];
                attribute = attribute->next;
            }
            [dataArr addObject:dict];
            [dict release];
        }
        
        //递归处理子树
        if (element->firstChild) {
            [self allXmlAttributeData:element->firstChild:tName];
        }
        //迭代处理兄弟树
    } while ((element = element->nextSibling));
}

+ (void)allXmlElementData:(TBXMLElement *)element:(NSString *)sListName:(NSString *)tName{
    do {
        if ([[TBXML elementName:element] isEqualToString:sListName]) {
            
            NSString *xmlString =  [TBXML textForElement:element];
            
            xmlString = [xmlString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlString = [xmlString stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            TBXML * child = [[TBXML alloc] initWithXMLString:xmlString];
            [self allXmlAttributeData:child.rootXMLElement :tName];
            
            [child release];
            break;
        }
        //递归处理子树
        if (element->firstChild) {
            [self allXmlElementData:element->firstChild :sListName :tName];
        }
        //迭代处理兄弟树
    } while ((element = element->nextSibling));
}
//  接收结果数据为： xml
+ (NSMutableArray *)getXmlToArr:(NSData *)data:(NSString *)dataRowName:(NSString *)GetResultFiled {
    
    dataArr = [[[NSMutableArray alloc] init] autorelease];
    
    TBXML * tbxml = [[TBXML alloc] initWithXMLData:data]; 
    
    [self allXmlElementData:tbxml.rootXMLElement :dataRowName :GetResultFiled];
    [tbxml release];
    
    return dataArr;
}



//read ElementAttribute
+ (void)allAttributeData:(TBXMLElement *)element:(NSString *)tName{
    do {
        if ([[TBXML elementName:element] isEqualToString:tName]) {
            
            TBXMLAttribute * attribute = element->firstAttribute;              
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            while (attribute) {
                
                [dict setObject:[TBXML attributeValue:attribute] forKey:[TBXML attributeName:attribute]];
                attribute = attribute->next;
            }
            [dataArr addObject:dict];
            [dict release];
        }
        //递归处理子树
        if (element->firstChild) {
            [self allAttributeData:element->firstChild:tName];
        }
        //迭代处理兄弟树
    } while ((element = element->nextSibling));
}

+ (NSMutableArray *)getAttributeToArr:(NSData *)data:(NSString *)tName{
    //    allFieldString = [NSMutableString string];
    //    insertSql = [NSMutableString string];
    dataArr = [[[NSMutableArray alloc] init] autorelease];
    
    //获得所有的属性名
    //    TBXML * tbxml = [[TBXML alloc] initWithXMLData:data]; 
    //    [self recuAllFiledName:tbxml.rootXMLElement :@"User"];
    //    NSLog(@"all filed:%@", allFieldString);    
    //    [self checkTable:@"User"];
    //    
    //    [tbxml release];
    
    
    //获得所有的数据并且写入数据库
    /* TBXML * xml = [[TBXML alloc] initWithXMLData:data]; 
     [self recuAllData:xml.rootXMLElement :@"User"];
     [xml release];
     
     NSLog(@"sql:%@", insertSql);
     [self insertData];
     */
    //获得所有数据写入nsarray
    TBXML * child = [[TBXML alloc] initWithXMLData:data]; 
    [self allAttributeData:child.rootXMLElement :tName];
    [child release];
    
    return dataArr;
}

@end
