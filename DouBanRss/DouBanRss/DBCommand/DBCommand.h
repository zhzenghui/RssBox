//
//  DBCommand.h
//  ZhenYeMobileCRM
//
//  Created by Zeng on 11-11-21.
//  Copyright (c) 2011年 山西振业. All rights reserved.
//

@class FMDatabase;
#import <Foundation/Foundation.h>

@interface DBCommand : NSObject

+ (FMDatabase *) nDB;
+ (NSString *)getDatabasePath;
+ (NSString *)getPath:(NSString *)dbName;

@end