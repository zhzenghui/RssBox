//
//  RssList.m
//  DouBanRss
//
//  Created by dong xin on 12-3-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RssList.h"

@implementation RssList

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
    
    // title ,link, description,  language , copyright , pubDate, isdelete, isedit UserID  ,orderTag, subscribe, datetime, recommendTag
    
    NSString *createRssList = @"CREATE TABLE RssListInfo ( \
    ID INTEGER  PRIMARY KEY AUTOINCREMENT , \
    title, \
    xmlUrl , \
    datetime, \
    isGet, \
    UserID )";
    
    [myDB executeUpdate:createRssList];
    
}

- (void)checkRssListTable:(NSString *)sqlStr {
    NSString *SQL = [NSString stringWithFormat:@"SELECT COUNT(*) FROM sqlite_master WHERE name = 'RssListInfo'", sqlStr];
    
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

- (BOOL)checkRssList:(NSString *)ID {
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM RssListinfo WHERE ID = '%@'", ID];
    
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

- (NSMutableArray *)getRssList:(NSString *)ID {
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM RssListinfo WHERE ID = '%@'", ID];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    
    rs = [myDB executeQuery:SQL];
    
    // title ,link, description,  language , copyright , pubDate, isdelete, isedit， UserID
    
    while ([rs next]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dict setValue:[rs stringForColumn:@"title"] forKey:@"title"];

        [dict setValue:[rs stringForColumn:@"xmlUrl"] forKey:@"xmlUrl"];  
        [dict setValue:[rs stringForColumn:@"isGet"] forKey:@"isGet"];  
        
        [dict setValue:[rs stringForColumn:@"datetime"] forKey:@"datetime"];
        [dict setValue:[rs stringForColumn:@"UserID"] forKey:@"UserID"];    
        
        
        [resultArr addObject:dict];
    }
    [rs close];
    
    return resultArr;
}

- (NSMutableArray *)getRssLists {
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM RssListinfo order by dateTime desc"];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    
    rs = [myDB executeQuery:SQL];
    
    // title ,link, description,  language , copyright , pubDate, isdelete, isedit， 
    
    while ([rs next]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dict setValue:[rs stringForColumn:@"title"] forKey:@"title"];
        
        [dict setValue:[rs stringForColumn:@"xmlUrl"] forKey:@"xmlUrl"];  
        [dict setValue:[rs stringForColumn:@"isGet"] forKey:@"isGet"];  
        
        [dict setValue:[rs stringForColumn:@"datetime"] forKey:@"datetime"];
        [dict setValue:[rs stringForColumn:@"UserID"] forKey:@"UserID"];            
        
        [resultArr addObject:dict];
    }
    [rs close];
    
    return resultArr;
}


- (void)insertRssList:(NSDictionary *)RssListDict {
    
    // title ,link, description,  language , copyright , pubDate, isdelete, isedit
    NSString *SQL = [NSString stringWithFormat:@"INSERT INTO RssListInfo ( \
                     title, \
                     xmlUrl , \
                     datetime, \
                     isGet, \
                     UserID ) \
                     values \
                     ('%@', '%@', '%@', '%@', '%@')",
                     [RssListDict objectForKey:@"title"], 
                     [RssListDict objectForKey:@"xmlUrl"], 
                     [RssListDict objectForKey:@"datetime"],
                     [RssListDict objectForKey:@"isget"],
                     [RssListDict objectForKey:@"UserID"] ];
    
    [myDB executeUpdate:SQL];
}

- (void)deleteRssList {
    NSMutableString *SQL = [NSMutableString string];
	[SQL setString:@"DELETE FROM RssListInfo "];
    
	[myDB executeUpdate:SQL];
}

- (void)deleteRssList:(NSString *)RssListID {
    NSMutableString *SQL = [NSMutableString string];
	[SQL setString:@"DELETE FROM RssListInfo "];
	[SQL appendFormat:@"WHERE ID = '%@' ",RssListID];
    
	[myDB executeUpdate:SQL];
}

- (void)updateRssList:(NSDictionary *)RssListDict {
    
    
    // title ,link, description,  language , copyright , pubDate, isdelete, isedit
    
	NSMutableString *SQL = [NSMutableString string];
    [SQL setString:@"UPDATE RssListInfo "];
    [SQL appendFormat:@"SET "];
    [SQL appendFormat:@"title = '%@', ", [RssListDict valueForKey:@"title"]];    
    [SQL appendFormat:@"xmlurl = '%@', ", [RssListDict valueForKey:@"xmlurl"]]; 
    [SQL appendFormat:@"isget = '%@', ", [RssListDict valueForKey:@"isget"]];
    [SQL appendFormat:@"UserID = '%@', ", [RssListDict valueForKey:@"UserID"]];
    
    [SQL appendFormat:@"datetime = '%@' ", [RssListDict valueForKey:@"datetime"]];
    
    [SQL appendFormat:@"where id = '%@'", [RssListDict valueForKey:@"ID"]];
    [myDB executeUpdate:SQL];
}


@end
