//
//  RssInfo.m
//  DouBanRss
//
//  Created by dong xin on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RssInfo.h"

@implementation RssInfo


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
    
    // title ,xmlUrl, description,  language , copyright , pubDate, isdelete, isedit UserID  ,orderTag, subscribe, datetime, recommendTag
    
   // parent
    NSString *createRss = @"CREATE TABLE RssInfo ( \
    ID INTEGER  PRIMARY KEY AUTOINCREMENT , \
    title, \
    xmlUrl , \
    description , \
    language ,\
    copyright , \
    orderTag, subscribe, datetime, recommendTag ,\
    isdelete, \
    isedit, \
    UserID , \
    pubDate TEXT )";
    
    [myDB executeUpdate:createRss];
    
}

- (void)checkRssTable:(NSString *)sqlStr {
    NSString *SQL = [NSString stringWithFormat:@"SELECT COUNT(*) FROM sqlite_master WHERE name = 'rssInfo'", sqlStr];
    
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

- (BOOL)checkRss:(NSString *)ID {
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM Rssinfo WHERE ID = '%@'", ID];
    
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

- (NSMutableArray *)getRss:(NSString *)ID {
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM Rssinfo WHERE ID = '%@'", ID];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    
    rs = [myDB executeQuery:SQL];
    
    // title ,xmlUrl, description,  language , copyright , pubDate, isdelete, isedit， UserID
    
    while ([rs next]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dict setValue:[rs stringForColumn:@"title"] forKey:@"title"];
        [dict setValue:[rs stringForColumn:@"xmlUrl"] forKey:@"xmlUrl"];
        [dict setValue:[rs stringForColumn:@"description"] forKey:@"description"];
        [dict setValue:[rs stringForColumn:@"language"] forKey:@"language"];
        [dict setValue:[rs stringForColumn:@"copyright"] forKey:@"copyright"];
        
        [dict setValue:[rs stringForColumn:@"orderTag"] forKey:@"orderTag"];
        [dict setValue:[rs stringForColumn:@"subscribe"] forKey:@"subscribe"];
        [dict setValue:[rs stringForColumn:@"datetime"] forKey:@"datetime"];
        [dict setValue:[rs stringForColumn:@"recommendTag"] forKey:@"recommendTag"];    
        
        [dict setValue:[rs stringForColumn:@"pubDate"] forKey:@"pubDate"];    
        [dict setValue:[rs stringForColumn:@"isdelete"] forKey:@"isdelete"];    
        [dict setValue:[rs stringForColumn:@"isedit"] forKey:@"isedit"];    
        [dict setValue:[rs stringForColumn:@"UserID"] forKey:@"UserID"];    
        

        [resultArr addObject:dict];
    }
    [rs close];
    
    return resultArr;
}


- (NSMutableArray *)getRsssSub {
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM Rssinfo where subscribe='1' order by dateTime desc"];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    
    rs = [myDB executeQuery:SQL];
    
    // title ,xmlUrl, description,  language , copyright , pubDate, isdelete, isedit， 
    
    while ([rs next]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dict setValue:[rs stringForColumn:@"title"] forKey:@"title"];        
        [dict setValue:[rs stringForColumn:@"xmlUrl"] forKey:@"xmlUrl"];
        [dict setValue:[rs stringForColumn:@"description"] forKey:@"description"];
        [dict setValue:[rs stringForColumn:@"language"] forKey:@"language"];
        [dict setValue:[rs stringForColumn:@"copyright"] forKey:@"copyright"];
        [dict setValue:[rs stringForColumn:@"pubDate"] forKey:@"pubDate"];
        
        [dict setValue:[rs stringForColumn:@"orderTag"] forKey:@"orderTag"];
        [dict setValue:[rs stringForColumn:@"subscribe"] forKey:@"subscribe"];
        [dict setValue:[rs stringForColumn:@"datetime"] forKey:@"datetime"];
        [dict setValue:[rs stringForColumn:@"recommendTag"] forKey:@"recommendTag"];    
        
        [dict setValue:[rs stringForColumn:@"isdelete"] forKey:@"isdelete"];
        [dict setValue:[rs stringForColumn:@"isedit"] forKey:@"isedit"];
        [dict setValue:[rs stringForColumn:@"UserID"] forKey:@"UserID"];            
        
        
        
        
        
        
        
        
        
        [resultArr addObject:dict];
    }
    [rs close];
    
    return resultArr;
}

- (NSMutableArray *)getRsss {
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM Rssinfo order by dateTime desc"];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    
    rs = [myDB executeQuery:SQL];
    
    // title ,xmlUrl, description,  language , copyright , pubDate, isdelete, isedit， 
    
    while ([rs next]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dict setValue:[rs stringForColumn:@"title"] forKey:@"title"];        
        [dict setValue:[rs stringForColumn:@"xmlUrl"] forKey:@"xmlUrl"];
        [dict setValue:[rs stringForColumn:@"description"] forKey:@"description"];
        [dict setValue:[rs stringForColumn:@"language"] forKey:@"language"];
        [dict setValue:[rs stringForColumn:@"copyright"] forKey:@"copyright"];
        [dict setValue:[rs stringForColumn:@"pubDate"] forKey:@"pubDate"];
        
        [dict setValue:[rs stringForColumn:@"orderTag"] forKey:@"orderTag"];
        [dict setValue:[rs stringForColumn:@"subscribe"] forKey:@"subscribe"];
        [dict setValue:[rs stringForColumn:@"datetime"] forKey:@"datetime"];
        [dict setValue:[rs stringForColumn:@"recommendTag"] forKey:@"recommendTag"];    
        
        [dict setValue:[rs stringForColumn:@"isdelete"] forKey:@"isdelete"];
        [dict setValue:[rs stringForColumn:@"isedit"] forKey:@"isedit"];
        [dict setValue:[rs stringForColumn:@"UserID"] forKey:@"UserID"];            


    
        
        
        
        
        
        
        [resultArr addObject:dict];
    }
    [rs close];
    
    return resultArr;
}


- (void)insertRss:(NSDictionary *)RssDict {
    
        // title ,xmlUrl, description,  language , copyright , pubDate, isdelete, isedit
    NSString *SQL = [NSString stringWithFormat:@"INSERT INTO RssInfo ( \
                      title ,xmlUrl, description,  language , copyright , orderTag, subscribe, datetime, recommendTag ,pubDate, isdelete, isedit, UserID) \
                     values \
                     ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')",
                     [RssDict objectForKey:@"title"], 
                     [RssDict objectForKey:@"xmlUrl"],  [RssDict objectForKey:@"description"], 
                     [RssDict objectForKey:@"language"], [RssDict objectForKey:@"copyright"], 

                    [RssDict objectForKey:@"orderTag"],  [RssDict objectForKey:@"subscribe"], 
                     
                     
                     [RssDict objectForKey:@"datetime"], [RssDict objectForKey:@"recommendTag"], 
                     
                     [RssDict objectForKey:@"pubDate"], [RssDict objectForKey:@"isdelete"], 
                     [RssDict objectForKey:@"isedit"],[RssDict objectForKey:@"UserID"] ];
    
    [myDB executeUpdate:SQL];
}

- (void)deleteRss:(NSString *)RssID {
    NSMutableString *SQL = [NSMutableString string];
	[SQL setString:@"DELETE FROM RssInfo "];
	[SQL appendFormat:@"WHERE ID = '%@' ",RssID];
    
	[myDB executeUpdate:SQL];
}

- (void)updateRss:(NSDictionary *)RssDict {
    
       
    // title ,xmlUrl, description,  language , copyright , pubDate, isdelete, isedit
    
	NSMutableString *SQL = [NSMutableString string];
    [SQL setString:@"UPDATE RssInfo "];
    [SQL appendFormat:@"SET "];
    [SQL appendFormat:@"title = '%@', ", [RssDict valueForKey:@"title"]];    
    [SQL appendFormat:@"xmlUrl = '%@', ", [RssDict valueForKey:@"xmlUrl"]]; 
    [SQL appendFormat:@"description = '%@', ", [RssDict valueForKey:@"description"]];
    [SQL appendFormat:@"language = '%@', ", [RssDict valueForKey:@"language"]];
    [SQL appendFormat:@"copyright = '%@', ", [RssDict valueForKey:@"copyright"]];
    [SQL appendFormat:@"pubdate = '%@', ", [RssDict valueForKey:@"pubdate"]];
    [SQL appendFormat:@"isdelete = '%@', ", [RssDict valueForKey:@"isdelete"]];
    [SQL appendFormat:@"isedit = '%@', ", [RssDict valueForKey:@"isedit"]];
    [SQL appendFormat:@"UserID = '%@', ", [RssDict valueForKey:@"UserID"]];
    
    [SQL appendFormat:@"orderTag = '%@', ", [RssDict valueForKey:@"orderTag"]];
    [SQL appendFormat:@"subscribe = '%@', ", [RssDict valueForKey:@"subscribe"]];
    [SQL appendFormat:@"datetime = '%@', ", [RssDict valueForKey:@"datetime"]];
    [SQL appendFormat:@"recommendTag = '%@' ", [RssDict valueForKey:@"recommendTag"]];

    [SQL appendFormat:@"where id = '%@'", [RssDict valueForKey:@"ID"]];
    [myDB executeUpdate:SQL];
}


@end
