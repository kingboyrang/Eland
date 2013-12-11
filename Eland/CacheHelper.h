//
//  CacheHelper.h
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIDownloadCache.h"
#import "PushResult.h"
@interface CacheHelper : NSObject
//乡镇
+(void)cacheCityFromArray:(NSArray*)citys;
+(NSArray*)readCacheCitys;
//案件类别
+(void)cacheCaseCategoryFromArray:(NSArray*)categorys;
+(NSArray*)readCacheCaseCategorys;
//推播信息
+(void)cacheCasePushResult:(PushResult*)entity;
+(void)cacheCasePushArray:(NSArray*)results;
+(void)cacheCasePushFromArray:(NSArray*)results;
+(NSArray*)readCacheCasePush;
//保存已删除的推播信息
+(void)cacheDeletePushWithGuid:(NSString*)guid;
+(NSArray*)readDeleteCasePush;
//项目设定
+(void)cacheCaseSettingsFromArray:(NSArray*)settings;
+(NSArray*)readCacheCaseSettings;
@end
