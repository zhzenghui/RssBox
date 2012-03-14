//
//  ItemInfo.m
//  DouBanItem
//
//  Created by dong xin on 12-3-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ItemInfo.h"

@implementation ItemInfo


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
    
    // title ,link, description,  language , copyright , pubDate, isHidden  0 1, isedit UserID  ,issave 0 1, ptitle  f 的title, datetime, recommendTag
    
    // parent
    NSString *createItem = @"CREATE TABLE ItemInfo ( \
    ID INTEGER  PRIMARY KEY AUTOINCREMENT , \
    title, \
    link , \
    description , \
    language ,\
    copyright , \
    issave, ptitle, datetime, recommendTag ,\
    isHidden, \
    isedit, \
    UserID , \
    pubDate TEXT )";
    
    [myDB executeUpdate:createItem];
    
}

- (void)checkItemTable:(NSString *)sqlStr {
    NSString *SQL = [NSString stringWithFormat:@"SELECT COUNT(*) FROM sqlite_master WHERE name = 'ItemInfo'", sqlStr];
    
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

- (BOOL)checkItem:(NSString *)ID {
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM Iteminfo WHERE ID = '%@'", ID];
    
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

- (NSMutableArray *)getItem:(NSString *)ID {
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM Iteminfo WHERE ID = '%@'", ID];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    
    rs = [myDB executeQuery:SQL];
    
    // title ,link, description,  language , copyright , pubDate, isHidden, isedit， UserID
    
    while ([rs next]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dict setValue:[rs stringForColumn:@"title"] forKey:@"title"];
        [dict setValue:[rs stringForColumn:@"link"] forKey:@"link"];
        [dict setValue:[rs stringForColumn:@"description"] forKey:@"description"];
        [dict setValue:[rs stringForColumn:@"language"] forKey:@"language"];
        [dict setValue:[rs stringForColumn:@"copyright"] forKey:@"copyright"];
        
        [dict setValue:[rs stringForColumn:@"issave"] forKey:@"issave"];
        [dict setValue:[rs stringForColumn:@"ptitle"] forKey:@"ptitle"];
        [dict setValue:[rs stringForColumn:@"datetime"] forKey:@"datetime"];
        [dict setValue:[rs stringForColumn:@"recommendTag"] forKey:@"recommendTag"];    
        
        [dict setValue:[rs stringForColumn:@"pubDate"] forKey:@"pubDate"];    
        [dict setValue:[rs stringForColumn:@"isHidden"] forKey:@"isHidden"];    
        [dict setValue:[rs stringForColumn:@"isedit"] forKey:@"isedit"];    
        [dict setValue:[rs stringForColumn:@"UserID"] forKey:@"UserID"];    
        
        
        [resultArr addObject:dict];
    }
    [rs close];
    
    return resultArr;
}


- (NSMutableArray *)getItemsPtitle :(NSString *)pTitle{
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM Iteminfo where ptitle = '%@' order by dateTime desc", pTitle];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    
    rs = [myDB executeQuery:SQL];
    
    // title ,link, description,  language , copyright , pubDate, isHidden, isedit， 
    
    while ([rs next]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dict setValue:[rs stringForColumn:@"title"] forKey:@"title"];        
        [dict setValue:[rs stringForColumn:@"link"] forKey:@"link"];
        [dict setValue:[rs stringForColumn:@"description"] forKey:@"description"];
        [dict setValue:[rs stringForColumn:@"language"] forKey:@"language"];
        [dict setValue:[rs stringForColumn:@"copyright"] forKey:@"copyright"];
        [dict setValue:[rs stringForColumn:@"pubDate"] forKey:@"pubDate"];
        
        [dict setValue:[rs stringForColumn:@"issave"] forKey:@"issave"];
        [dict setValue:[rs stringForColumn:@"ptitle"] forKey:@"ptitle"];
        [dict setValue:[rs stringForColumn:@"datetime"] forKey:@"datetime"];
        [dict setValue:[rs stringForColumn:@"recommendTag"] forKey:@"recommendTag"];    
        
        [dict setValue:[rs stringForColumn:@"isHidden"] forKey:@"isHidden"];
        [dict setValue:[rs stringForColumn:@"isedit"] forKey:@"isedit"];
        [dict setValue:[rs stringForColumn:@"UserID"] forKey:@"UserID"];            
        
        [resultArr addObject:dict];
    }
    [rs close];
    
    return resultArr;
}

- (NSMutableArray *)getItems {
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM Iteminfo order by dateTime desc"];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    
    rs = [myDB executeQuery:SQL];
    
    // title ,link, description,  language , copyright , pubDate, isHidden, isedit， 
    
    while ([rs next]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dict setValue:[rs stringForColumn:@"title"] forKey:@"title"];        
        [dict setValue:[rs stringForColumn:@"link"] forKey:@"link"];
        [dict setValue:[rs stringForColumn:@"description"] forKey:@"description"];
        [dict setValue:[rs stringForColumn:@"language"] forKey:@"language"];
        [dict setValue:[rs stringForColumn:@"copyright"] forKey:@"copyright"];
        [dict setValue:[rs stringForColumn:@"pubDate"] forKey:@"pubDate"];
        
        [dict setValue:[rs stringForColumn:@"issave"] forKey:@"issave"];
        [dict setValue:[rs stringForColumn:@"ptitle"] forKey:@"ptitle"];
        [dict setValue:[rs stringForColumn:@"datetime"] forKey:@"datetime"];
        [dict setValue:[rs stringForColumn:@"recommendTag"] forKey:@"recommendTag"];    
        
        [dict setValue:[rs stringForColumn:@"isHidden"] forKey:@"isHidden"];
        [dict setValue:[rs stringForColumn:@"isedit"] forKey:@"isedit"];
        [dict setValue:[rs stringForColumn:@"UserID"] forKey:@"UserID"];            
        
        [resultArr addObject:dict];
    }
    [rs close];
    
    return resultArr;
}


- (void)insertItem:(NSDictionary *)ItemDict {
    
    // title ,link, description,  language , copyright , pubDate, isHidden, isedit
    NSString *SQL = [NSString stringWithFormat:@"INSERT INTO ItemInfo ( \
                     title ,link, description,  language , copyright , issave, ptitle, datetime, recommendTag ,pubDate, isHidden, isedit, UserID) \
                     values \
                     ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')",
                     [ItemDict objectForKey:@"title"], 
                     [ItemDict objectForKey:@"link"],    [ItemDict objectForKey:@"description"], 
                     [ItemDict objectForKey:@"language"], [ItemDict objectForKey:@"copyright"], 
                     
                     [ItemDict objectForKey:@"issave"], [ItemDict objectForKey:@"ptitle"], 

                     [ItemDict objectForKey:@"datetime"],  [ItemDict objectForKey:@"recommendTag"], 
                     
                     [ItemDict objectForKey:@"pubDate"], [ItemDict objectForKey:@"isHidden"], 
                     [ItemDict objectForKey:@"isedit"],[ItemDict objectForKey:@"UserID"] ];
    
    [myDB executeUpdate:SQL];
}

- (void)deleteItem:(NSString *)ItemID {
    NSMutableString *SQL = [NSMutableString string];
	[SQL setString:@"DELETE FROM ItemInfo "];
	[SQL appendFormat:@"WHERE ID = '%@' ",ItemID];
    
	[myDB executeUpdate:SQL];
}

- (void)updateItem:(NSDictionary *)ItemDict {
    
    
    // title ,link, description,  language , copyright , pubDate, isHidden, isedit
    
	NSMutableString *SQL = [NSMutableString string];
    [SQL setString:@"UPDATE ItemInfo "];
    [SQL appendFormat:@"SET "];
    [SQL appendFormat:@"title = '%@', ", [ItemDict valueForKey:@"title"]];    
    [SQL appendFormat:@"link = '%@', ", [ItemDict valueForKey:@"link"]]; 
    [SQL appendFormat:@"description = '%@', ", [ItemDict valueForKey:@"description"]];
    [SQL appendFormat:@"language = '%@', ", [ItemDict valueForKey:@"language"]];
    [SQL appendFormat:@"copyright = '%@', ", [ItemDict valueForKey:@"copyright"]];
    [SQL appendFormat:@"pubdate = '%@', ", [ItemDict valueForKey:@"pubdate"]];
    [SQL appendFormat:@"isHidden = '%@', ", [ItemDict valueForKey:@"isHidden"]];
    [SQL appendFormat:@"isedit = '%@', ", [ItemDict valueForKey:@"isedit"]];
    [SQL appendFormat:@"UserID = '%@', ", [ItemDict valueForKey:@"UserID"]];
    
    [SQL appendFormat:@"issave = '%@', ", [ItemDict valueForKey:@"issave"]];
    [SQL appendFormat:@"ptitle = '%@', ", [ItemDict valueForKey:@"ptitle"]];
    [SQL appendFormat:@"datetime = '%@', ", [ItemDict valueForKey:@"datetime"]];
    [SQL appendFormat:@"recommendTag = '%@' ", [ItemDict valueForKey:@"recommendTag"]];
    
    [SQL appendFormat:@"where id = '%@'", [ItemDict valueForKey:@"ID"]];
    [myDB executeUpdate:SQL];
}


@end
