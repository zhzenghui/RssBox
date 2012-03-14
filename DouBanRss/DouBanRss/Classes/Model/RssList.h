//
//  RssList.h
//  DouBanRss
//
//  Created by dong xin on 12-3-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//  xmlurl

//   title

//   datetime


#import "FMDatabase.h"
#import "FMResultSet.h"
#import "DBCommand.h"

@interface RssList : NSObject {
	FMDatabase		*myDB;
	FMResultSet		*rs;
}

@property (nonatomic ,retain) FMDatabase		*myDB;

-(id) init ;

- (void)createTable;

- (void)checkRssListTable:(NSString *)sqlStr ;

- (BOOL)checkRssList:(NSString *)ID ;

- (NSMutableArray *)getRssList:(NSString *)ID;

- (NSMutableArray *)getRssLists;

- (void)insertRssList:(NSDictionary *)RssListDict;

- (void)deleteRssList:(NSString *)RssListID ;

- (void)deleteRssList;

- (void)updateRssList:(NSDictionary *)RssListDict;



@end
