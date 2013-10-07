//
//  LevelCase.m
//  Eland
//
//  Created by aJia on 13/10/7.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "LevelCase.h"
#import "CaseCategoryHelper.h"
#import "NSString+TPCategory.h"
@implementation LevelCase
//通报时间
-(NSString*)formatDataTw{
    NSString *date=[self getPropertyValue:self.ApplyDate];
    if ([date length]==0) {return @"";}
    date=[date stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSRange range = [date  rangeOfString:@":" options:NSBackwardsSearch];
    if (range.location!=NSNotFound) {
        int pos=range.location;
        date=[date substringWithRange:NSMakeRange(0, pos)];
    }
    int y=[[date substringWithRange:NSMakeRange(0, 4)] intValue];
    return [NSString stringWithFormat:@"%d%@",y-1911,[date stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@""]];
}
-(NSString*)StatusText{
    NSString *str=[self getPropertyValue:self.Status];
    if ([[str Trim] isEqualToString:@"1"]) return @"辦理中";
    return @"已處理";
}
-(NSString*)CategoryName{
    NSString *str=[self getPropertyValue:self.CaseSettingGuid];
    if ([str length]==0) {return @"";}
    return [CaseCategoryHelper getCategoryName:str];
}
@end
