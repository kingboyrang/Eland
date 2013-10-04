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
@end
