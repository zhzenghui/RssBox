//
//  ItemInfo.h
//  DouBanRss
//
//  Created by dong xin on 12-3-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDatabase.h"
#import "FMResultSet.h"
#import "DBCommand.h"

@interface ItemInfo : NSObject {
	FMDatabase		*myDB;
	FMResultSet		*rs;
}

@property (nonatomic ,retain) FMDatabase		*myDB;

-(id) init ;

- (void)createTable;

- (void)checkItemTable:(NSString *)sqlStr ;

- (BOOL)checkItem:(NSString *)ID ;

- (NSMutableArray *)getItem:(NSString *)ID;

- (NSMutableArray *)getItemsPtitle :(NSString *)pTitle;
    
- (NSMutableArray *)getItems;

- (void)insertItem:(NSDictionary *)ItemDict;

- (void)deleteItem:(NSString *)ItemID ;

- (void)updateItem:(NSDictionary *)ItemDict;


@end
