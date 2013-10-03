//
//  CaseApplicant.m
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseApplicant.h"

@implementation CaseApplicant
-(NSString*)XmlSerialize{
     NSMutableString *xml=[NSMutableString stringWithFormat:@"<Applicant>"];
    [xml appendFormat:@"<Name>%@</Name>",[self getPropertyValue:_Name]];
    [xml appendFormat:@"<Nick>%@</Nick>",[self getPropertyValue:_Nick]];
    [xml appendFormat:@"<Phone>%@</Phone>",[self getPropertyValue:_Phone]];
    [xml appendFormat:@"<Tel>%@</Tel>",[self getPropertyValue:_Tel]];
    [xml appendFormat:@"<FaxTel>%@</FaxTel>",[self getPropertyValue:_FaxTel]];
    [xml appendFormat:@"<Email>%@</Email>",[self getPropertyValue:_Email]];
    [xml appendFormat:@"<Address>%@</Address>",[self getPropertyValue:_Address]];
    [xml appendString:@"</Applicant>"];
    return xml;
}
@end
