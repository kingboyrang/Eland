//
//  CacheHelper.m
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CacheHelper.h"
#import "FileHelper.h"
#import "PushResult.h"
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
    if (entity) {
        NSArray *arr=[self readCacheCasePush];
        NSMutableArray *source=[NSMutableArray array];
        if (arr&&[arr count]>0) {
            [source addObjectsFromArray:arr];
        }
        int index;
        BOOL boo=[PushResult existsPushResultWithGuid:entity.GUID index:&index];
        if (boo) {
            [source replaceObjectAtIndex:index withObject:entity];
        }else{
            [source addObject:entity];
        }
        [CacheHelper cacheCaseSettingsFromArray:source];
    }
}
+(void)cacheCasePushArray:(NSArray*)results{
    if (results&&[results count]>0) {
    NSMutableArray *source=[NSMutableArray array];
    NSArray *arr=[self readCacheCasePush];
    if (arr&&[arr count]>0) {
        [source addObjectsFromArray:arr];
    }
    for (PushResult *item in results) {
        int index;
        BOOL boo=[PushResult existsPushResultWithGuid:item.GUID index:&index];
        if (boo) {
            [source replaceObjectAtIndex:index withObject:item];
        }else{
            [source addObject:item];
        }
    }
    [CacheHelper cacheCaseSettingsFromArray:source];
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
