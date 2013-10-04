//
//  CaseCityHelper.m
//  Eland
//
//  Created by aJia on 13/10/4.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseCityHelper.h"
#import "CaseCity.h"
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
@end
