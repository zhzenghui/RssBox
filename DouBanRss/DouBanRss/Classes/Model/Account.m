//
//  Account.m
//  DouBanRss
//
//  Created by dong xin on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Account.h"

@implementation Account

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


- (void)createTable{
    
    // id ,userName, name,  pwd , state, isedit, datetime
    
    NSString *createUser = @"CREATE TABLE UserInfo ( \
    ID INTEGER  PRIMARY KEY AUTOINCREMENT , \
    userName, \
    name , \
    pwd , \
    state ,\
    isedit , \
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

- (BOOL)checkUser:(NSString *)ID {
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM userinfo WHERE ID = '%@'", ID];
    
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

- (NSMutableArray *)getUser:(NSString *)ID {
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM userinfo WHERE ID = '%@'", ID];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    
    rs = [myDB executeQuery:SQL];
    
    while ([rs next]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dict setValue:[rs stringForColumn:@"name"] forKey:@"name"];
        [dict setValue:[rs stringForColumn:@"userName"] forKey:@"userName"];
        [dict setValue:[rs stringForColumn:@"pwd"] forKey:@"pwd"];
        [dict setValue:[rs stringForColumn:@"state"] forKey:@"state"];
        [dict setValue:[rs stringForColumn:@"dateTime"] forKey:@"dateTime"];
        
        [dict setValue:[rs stringForColumn:@"isedit"] forKey:@"isedit"];     
        [resultArr addObject:dict];
    }
    [rs close];
    
    return resultArr;
}

- (NSMutableArray *)getUsers {
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM userinfo order by dateTime desc"];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    
    rs = [myDB executeQuery:SQL];
    
        // id ,userName, name,  pwd , state, isedit, datetime
    while ([rs next]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dict setValue:[rs stringForColumn:@"name"] forKey:@"name"];
        [dict setValue:[rs stringForColumn:@"userName"] forKey:@"userName"];
        [dict setValue:[rs stringForColumn:@"pwd"] forKey:@"pwd"];
        [dict setValue:[rs stringForColumn:@"state"] forKey:@"state"];
        [dict setValue:[rs stringForColumn:@"dateTime"] forKey:@"dateTime"];
        
        [dict setValue:[rs stringForColumn:@"isedit"] forKey:@"isedit"];

        
        [resultArr addObject:dict];
    }
    [rs close];
    
    return resultArr;
}


- (void)insertUser:(NSDictionary *)userDict {
    NSString *SQL = [NSString stringWithFormat:@"INSERT INTO UserInfo ( \
                     userName, name,  pwd , state, isedit, datetime) \
                     values \
                     ('%@', '%@', '%@', '%@', '%@', '%@')",
                     [userDict objectForKey:@"userName"], 
                     [userDict objectForKey:@"name"],    [userDict objectForKey:@"pwd"], 
                     [userDict objectForKey:@"state"],      [userDict objectForKey:@"isedit"], 
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
    
    //userName, name,  pwd , state, isedit, datetime
    
	NSMutableString *SQL = [NSMutableString string];
    [SQL setString:@"UPDATE UserInfo "];
    [SQL appendFormat:@"SET "];
    [SQL appendFormat:@"name = '%@', ", [userDict valueForKey:@"name"]];    
    [SQL appendFormat:@"userName = '%@', ", [userDict valueForKey:@"userName"]]; 
    [SQL appendFormat:@"pwd = '%@', ", [userDict valueForKey:@"pwd"]];
    [SQL appendFormat:@"state = '%@', ", [userDict valueForKey:@"state"]];
    [SQL appendFormat:@"isedit = '%@', ", [userDict valueForKey:@"isedit"]];
    [SQL appendFormat:@"datetime = '%@', ", [userDict valueForKey:@"datetime"]];

    [SQL appendFormat:@"where id = '%@'", [userDict valueForKey:@"ID"]];
    [myDB executeUpdate:SQL];
}


@end
