//
//  SearchArgs.m
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "SearchArgs.h"

@implementation SearchArgs
-(NSString*)toXmlString{
    if (_Pager!=nil) {
        return [_Pager toXmlString];
    }
    NSMutableString *xml=[NSMutableString stringWithFormat:@"<Pager>"];
    [xml appendFormat:@"<PageNumber>%d</PageNumber>",0];
    [xml appendFormat:@"<PageSize>%d</PageSize>",0];
    [xml appendFormat:@"<TotalItemsCount>%d</TotalItemsCount>",0];
    [xml appendFormat:@"<TotalPageCount>%d</TotalPageCount>",0];
    [xml appendString:@"</Pager>"];
    return xml;
}
@end
