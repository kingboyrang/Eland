//
//  CaseCityHelper.m
//  Eland
//
//  Created by aJia on 13/10/4.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseCityHelper.h"
#import "CaseCity.h"
#import "CacheHelper.h"
@implementation CaseCityHelper
+(NSMutableArray*)sourceFromArray:(NSArray*)arr{
    CaseCity *item=[[[CaseCity alloc] init] autorelease];
    item.Name=@"全部";
    item.GUID=@"";
    item.ParentGuid=@"";
    NSMutableArray *result=[NSMutableArray array];
    [result addObject:item];
    if (arr&&[arr count]>0) {
        [result addObjectsFromArray:arr];
    }
    return result;
}
+(NSString*)getCityName:(NSString*)guid{
    NSArray *arr=[CacheHelper readCacheCitys];
    if (arr==nil||[arr count]==0) {
        return @"";
    }
    NSString *match=[NSString stringWithFormat:@"SELF.GUID =='%@'",guid];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:match];
    NSArray *results = [arr filteredArrayUsingPredicate:predicate];
    if (results&&[results count]>0) {
        CaseCity *item=[results objectAtIndex:0];
        return item.Name;
    }
    return @"";
}
@end
