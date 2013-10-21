//
//  CaseImage.m
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseImage.h"
@implementation CaseImage
-(NSString*)XmlSerialize{
    NSMutableString *xml=[NSMutableString stringWithFormat:@"<CaseImage>"];
    [xml appendFormat:@"<Name>%@</Name>",[self getPropertyValue:_Name]];
    [xml appendFormat:@"<Content>%@</Content>",[self getPropertyValue:_Content]];
    [xml appendString:@"</CaseImage>"];
    return xml;

}
@end
