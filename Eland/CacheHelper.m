//
//  CacheHelper.m
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CacheHelper.h"
#import "FileHelper.h"
@implementation CacheHelper
+(void)cacheCityFromArray:(NSArray*)citys{
    if (citys&&[citys count]>0) {
        NSString *path=[DocumentPath stringByAppendingPathComponent:@"CacheCity"];
        [NSKeyedArchiver archiveRootObject:citys toFile:path];
    }
}
+(NSArray*)readCacheCitys{
   NSString *path=[DocumentPath stringByAppendingPathComponent:@"CacheCity"];
   if(![FileHelper existsFilePath:path]){ //如果不存在
       return nil;
   }
   NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile: path];
   return arr;
}
+(void)cacheCaseCategoryFromArray:(NSArray*)categorys{
    if (categorys&&[categorys count]>0) {
        NSString *path=[DocumentPath stringByAppendingPathComponent:@"CacheCaseCategory"];
        [NSKeyedArchiver archiveRootObject:categorys toFile:path];
    }
}
+(NSArray*)readCacheCaseCategorys{
    NSString *path=[DocumentPath stringByAppendingPathComponent:@"CacheCaseCategory"];
    if(![FileHelper existsFilePath:path]){ //如果不存在
        return nil;
    }
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile: path];
    return arr;
}
+(void)cacheCasePushResult:(PushResult*)entity{
    NSArray *arr=[self readCacheCasePush];
    if (entity) {
        if (arr!=nil&&[arr count]>0) {
            NSMutableArray *saveArr=[NSMutableArray arrayWithArray:arr];
            [saveArr addObject:entity];
            [self cacheCasePushFromArray:saveArr];
        }else{
            [self cacheCasePushFromArray:[NSArray arrayWithObjects:entity, nil]];
        }
    }
}
+(void)cacheCasePushFromArray:(NSArray*)results{
    if (results&&[results count]>0) {
        NSString *path=[DocumentPath stringByAppendingPathComponent:@"CachePush"];
        [NSKeyedArchiver archiveRootObject:results toFile:path];
    }
}
+(NSArray*)readCacheCasePush{
    NSString *path=[DocumentPath stringByAppendingPathComponent:@"CachePush"];
    if(![FileHelper existsFilePath:path]){ //如果不存在
        return nil;
    }
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile: path];
    return arr;
}
+(void)cacheCaseSettingsFromArray:(NSArray*)settings{
    if (settings&&[settings count]>0) {
        NSString *path=[DocumentPath stringByAppendingPathComponent:@"CacheCaseSettings"];
        [NSKeyedArchiver archiveRootObject:settings toFile:path];
    }
}
+(NSArray*)readCacheCaseSettings{
    NSString *path=[DocumentPath stringByAppendingPathComponent:@"CacheCaseSettings"];
    if(![FileHelper existsFilePath:path]){ //如果不存在
        return nil;
    }
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile: path];
    return arr;
}
@end
