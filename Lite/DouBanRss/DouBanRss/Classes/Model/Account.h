//
//  Account.h
//  DouBanRss
//
//  Created by dong xin on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDatabase.h"
#import "FMResultSet.h"
#import "DBCommand.h"

@interface Account : NSObject {
	FMDatabase		*myDB;
	FMResultSet		*rs;
}

@property (nonatomic ,retain) FMDatabase		*myDB;

- (void)createTable;

- (void)checkUserTable:(NSString *)sqlStr ;

- (BOOL)checkUser:(NSString *)ID ;

- (NSMutableArray *)getUser:(NSString *)ID;

- (NSMutableArray *)getUsers;

- (void)insertUser:(NSDictionary *)userDict;

- (void)deleteUser:(NSString *)userID ;

- (void)updateUser:(NSDictionary *)userDict;

@end
