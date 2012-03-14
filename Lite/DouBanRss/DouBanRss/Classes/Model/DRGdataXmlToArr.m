//
//  DRGdataXmlToArr.m
//  RssBox
//
//  Created by dong xin on 12-3-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DRGdataXmlToArr.h"

@implementation DRGdataXmlToArr

+ (NSMutableArray *)getElementToArr1:(NSData *)data:(NSString *)tName{
    
    NSMutableArray *elementArr = [NSMutableArray array];
    
    
    
    NSError *error;
//    GDataXMLDocument* doc = 
//    [[GDataXMLDocument alloc] initWithData:data encoding:NSUTF8StringEncoding]; //[[NSString alloc] initWithData:data    encoding: CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];    

    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:&error ]; // [[GDataXMLDocument alloc] initWithXMLString: responseXMLResult                                                                options:0 error:&error];
    
    
    NSLog(@"%@" ,  doc.rootElement);
    
    NSArray *partyMembers = [doc.rootElement elementsForName:@"/opml"];
//    NSArray *partyMembers = [doc.rootElement nodesForXPath:@"outline" error:nil];

    
    for (GDataXMLElement *partyMember in partyMembers) {
        
        NSString *_name;

        // Name
        NSMutableDictionary *dictRssInfo = [[NSMutableDictionary alloc] init];
        NSArray *names = [partyMember nodesForXPath:@"item" error:nil];
        if (names.count > 0) {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            _name = firstName.XMLString;
            
            [dictRssInfo setObject:@"" forKey:@"title"];
            

            
        } else continue;
        
        [elementArr addObject:dictRssInfo];
        [dictRssInfo release];
    }
    
    [doc release];
    return elementArr;
    
}


@end
