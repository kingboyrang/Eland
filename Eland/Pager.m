//
//  Pager.m
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "Pager.h"

@implementation Pager
-(void)setTotalItemsCount:(int)itemCount
{
    _TotalItemsCount=itemCount;
    _TotalPageCount=itemCount%_PageSize==0?itemCount/_PageSize:(itemCount/_PageSize)+1;
}
-(NSString*)toXmlString
{
    NSMutableString *xml=[NSMutableString stringWithFormat:@"<Pager>"];
    [xml appendFormat:@"<PageNumber>%d</PageNumber>",_PageNumber];
    [xml appendFormat:@"<PageSize>%d</PageSize>",_PageSize];
    [xml appendFormat:@"<TotalItemsCount>%d</TotalItemsCount>",_TotalItemsCount];
    //[xml appendFormat:@"<TotalPageCount>%d</TotalPageCount>",_TotalPageCount];
    [xml appendString:@"</Pager>"];
    return xml;
}
@end
