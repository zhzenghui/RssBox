//
//  DBCommand.m
//  ZhenYeMobileCRM
//
//  Created by Zeng on 11-11-21.
//  Copyright (c) 2011年 山西振业. All rights reserved.
//

#define KdbName @"rssData.db"
#define KtmpdbName @"tmpRssData"

#import "DBCommand.h"
#import "FMDatabase.h"

@implementation DBCommand

+ (FMDatabase *)nDB
{
	FMDatabase *myDB = [FMDatabase databaseWithPath:[DBCommand getDatabasePath]];
	return myDB; 
}

+(NSString *)getDatabasePath
{
	return [DBCommand getPath:KdbName];
}

+(NSString *)getTmpDatabasePath
{
	return [DBCommand getPath:KtmpdbName];
}

+(NSString *)getPath:(NSString *)dbName
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
	NSString *documentsDirectory = [paths objectAtIndex:0]; 
	NSString *dbPath = [[[NSString alloc] initWithFormat:@"%@/%@", documentsDirectory, dbName] autorelease];
	return dbPath;
}

@end

