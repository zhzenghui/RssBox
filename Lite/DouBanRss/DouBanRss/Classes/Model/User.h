//
//  User.h
//  ZYSharePoint
//
//  Created by Zeng on 11-12-12.
//  Copyright (c) 2011年 山西振业. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDatabase.h"
#import "FMResultSet.h"
#import "DBCommand.h"

@interface User : NSObject {
	FMDatabase		*myDB;
	FMResultSet		*rs;
}

@property (nonatomic ,retain) FMDatabase		*myDB;

- (void)clearUsersState;
- (void)createTable;
- (void)checkUserTable:(NSString *)sqlStr;
- (BOOL)checkUser:(NSString *)siteName;
    
- (NSMutableArray *)getUsers;
- (NSMutableArray *)getUser:(NSString *)sqlStr;
- (NSMutableArray *)getUser;

- (void)insertUser:(NSDictionary *)userDict;
- (void)updateUser:(NSDictionary *)userDict;
- (void)deleteUser:(NSString *)userID;

@end
