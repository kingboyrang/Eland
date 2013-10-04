//
//  CacheHelper.h
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIDownloadCache.h"
@interface CacheHelper : NSObject
+(void)cacheCityFromArray:(NSArray*)citys;
+(NSArray*)readCacheCitys;

+(void)cacheCaseCategoryFromArray:(NSArray*)categorys;
+(NSArray*)readCacheCaseCategorys;
@end
