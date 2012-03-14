//
//  RssInfo.h
//  DouBanRss
//
//  Created by dong xin on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDatabase.h"
#import "FMResultSet.h"
#import "DBCommand.h"

@interface RssInfo : NSObject {
	FMDatabase		*myDB;
	FMResultSet		*rs;
}

@property (nonatomic ,retain) FMDatabase		*myDB;

-(id) init ;

- (void)createTable;

- (void)checkRssTable:(NSString *)sqlStr ;

- (BOOL)checkRss:(NSString *)ID ;

- (NSMutableArray *)getRss:(NSString *)ID;

- (NSMutableArray *)getRsssSub;
    
- (NSMutableArray *)getRsss;

- (void)insertRss:(NSDictionary *)RssDict;

- (void)deleteRss:(NSString *)RssID ;

- (void)updateRss:(NSDictionary *)RssDict;

@end
