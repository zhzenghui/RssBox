//
//  User.m
//  ZYSharePoint
//
//  Created by Zeng on 11-12-12.
//  Copyright (c) 2011年 山西振业. All rights reserved.
//

#import "User.h"
#import "DBCommand.h"


@implementation User

@synthesize myDB;

-(id) init {
	if(self)
	{	
		self=[super init];
        
		self.myDB = [FMDatabase databaseWithPath:[DBCommand getDatabasePath]];
		[self.myDB open];
    }
	return self;
}

- (void) dealloc{
    [self.myDB close];
    [self.myDB release];    
    [super dealloc];
}

- (void)clearUsersState{
    NSMutableString *SQL = [NSMutableString string];
    [SQL setString:@"UPDATE UserInfo "];
    [SQL appendFormat:@"SET state = '%@' ",@"0"];
    [SQL appendFormat:@"where state = '1'"];
    [myDB executeUpdate:SQL];
}

- (void)createTable{
    
    NSString *createUser = @"CREATE TABLE UserInfo ( \
                            ID INTEGER  PRIMARY KEY AUTOINCREMENT , \
                            siteName, \
                            userName, \
                            pwd, \
                            server, \
                            userDomain, \
                            state, \
                            authentication, \
                            dateTime TEXT )";
    
    [myDB executeUpdate:createUser];
    
}

- (void)checkUserTable:(NSString *)sqlStr {
    NSString *SQL = [NSString stringWithFormat:@"SELECT COUNT(*) FROM sqlite_master WHERE name = '%@'", sqlStr];
    
    rs = [myDB executeQuery:SQL];
    int productTableCount = 0;
    
    while ([rs next]) {
        productTableCount = [rs intForColumnIndex:0];              
    }
    [rs close];
    if (productTableCount == 0) {
        [self createTable];
    }  
}

- (BOOL)checkUser:(NSString *)siteName {
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM userinfo WHERE siteName = '%@'", siteName];
    
    rs = [myDB executeQuery:SQL];
    int productTableCount = 0;
    
    while ([rs next]) {
        productTableCount = [rs intForColumnIndex:0];              
    }
    [rs close];
    if (productTableCount != 0) {
        return YES;
    }  
    else 
        return NO;
}

- (NSMutableArray *)getUsers {
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM userinfo order by dateTime desc"];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    
    rs = [myDB executeQuery:SQL];
    
    while ([rs next]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dict setValue:[rs stringForColumn:@"siteName"] forKey:@"siteName"];
        [dict setValue:[rs stringForColumn:@"userName"] forKey:@"userName"];
        [dict setValue:[rs stringForColumn:@"pwd"] forKey:@"pwd"];
        [dict setValue:[rs stringForColumn:@"userDomain"] forKey:@"userDomain"];
        [dict setValue:[rs stringForColumn:@"server"] forKey:@"server"];
        [dict setValue:[rs stringForColumn:@"state"] forKey:@"state"];
        [dict setValue:[rs stringForColumn:@"authentication"] forKey:@"authentication"];
        [dict setValue:[rs stringForColumn:@"dateTime"] forKey:@"dateTime"];
        
        [resultArr addObject:dict];
    }
    [rs close];
    
    return resultArr;
}


- (NSMutableArray *)getUser{
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM userinfo WHERE state = '1'"];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    
    rs = [myDB executeQuery:SQL];
    
    while ([rs next]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dict setValue:[rs stringForColumn:@"siteName"] forKey:@"siteName"];
        [dict setValue:[rs stringForColumn:@"userName"] forKey:@"userName"];
        [dict setValue:[rs stringForColumn:@"pwd"] forKey:@"pwd"];
        [dict setValue:[rs stringForColumn:@"userDomain"] forKey:@"userDomain"];
        [dict setValue:[rs stringForColumn:@"server"] forKey:@"server"];
        [dict setValue:[rs stringForColumn:@"state"] forKey:@"state"];
        [dict setValue:[rs stringForColumn:@"authentication"] forKey:@"authentication"];
        [dict setValue:[rs stringForColumn:@"dateTime"] forKey:@"dateTime"];
        
        [resultArr addObject:dict];
    }
    [rs close];
    
    return resultArr;
}
- (NSMutableArray *)getUser:(NSString *)sqlStr {
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM userinfo WHERE username = '%@'", sqlStr];
   
    NSMutableArray *resultArr = [NSMutableArray array];
    
    rs = [myDB executeQuery:SQL];
    
    while ([rs next]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dict setValue:[rs stringForColumn:@"siteName"] forKey:@"siteName"];        
        [dict setValue:[rs stringForColumn:@"userName"] forKey:@"userName"];
        [dict setValue:[rs stringForColumn:@"pwd"] forKey:@"pwd"];
        [dict setValue:[rs stringForColumn:@"userDomain"] forKey:@"userDomain"];
        [dict setValue:[rs stringForColumn:@"server"] forKey:@"server"];
        [dict setValue:[rs stringForColumn:@"state"] forKey:@"state"];
        [dict setValue:[rs stringForColumn:@"authentication"] forKey:@"authentication"];
        [dict setValue:[rs stringForColumn:@"dateTime"] forKey:@"dateTime"];
        
        [resultArr addObject:dict];
    }
    [rs close];
    
    return resultArr;
}

- (void)insertUser:(NSDictionary *)userDict {
    NSString *SQL = [NSString stringWithFormat:@"INSERT INTO UserInfo ( \
                     siteName, userName, pwd, server, userDomain, state, authentication,  dateTime ) \
                     values \
                     ('%@', '%@', '%@', '%@', '%@', '%@', '%@','%@')",
                     [userDict objectForKey:@"siteName"], 
                    [userDict objectForKey:@"userName"],    [userDict objectForKey:@"pwd"], 
                    [userDict objectForKey:@"server"],      [userDict objectForKey:@"userDomain"], 
                    [userDict objectForKey:@"state"],       [userDict objectForKey:@"authentication"],
                    [userDict objectForKey:@"dateTime"]];
    
    [myDB executeUpdate:SQL];
}

- (void)deleteUser:(NSString *)userID {
    NSMutableString *SQL = [NSMutableString string];
	[SQL setString:@"DELETE FROM UserInfo "];
	[SQL appendFormat:@"WHERE ID = '%@' ",userID];

	[myDB executeUpdate:SQL];
}

- (void)updateUser:(NSDictionary *)userDict {
    
	NSMutableString *SQL = [NSMutableString string];
    [SQL setString:@"UPDATE UserInfo "];
    [SQL appendFormat:@"SET "];
    [SQL appendFormat:@"siteName = '%@', ", [userDict valueForKey:@"siteName"]];    
    [SQL appendFormat:@"userName = '%@', ", [userDict valueForKey:@"userName"]]; 
    [SQL appendFormat:@"pwd = '%@', ", [userDict valueForKey:@"pwd"]];
    [SQL appendFormat:@"server = '%@', ", [userDict valueForKey:@"server"]];
    [SQL appendFormat:@"userDomain = '%@', ", [userDict valueForKey:@"userDomain"]];
    [SQL appendFormat:@"state = '%@', ", [userDict valueForKey:@"state"]];
    [SQL appendFormat:@"authentication = '%@', ", [userDict valueForKey:@"authentication"]];
    [SQL appendFormat:@"dateTime = '%@' ", [userDict valueForKey:@"dateTime"]];
    [SQL appendFormat:@"where id = '%@'", [userDict valueForKey:@"ID"]];
    [myDB executeUpdate:SQL];
}
@end
