//
//  LevelCaseArgs.m
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "LevelCaseArgs.h"

@interface LevelCaseArgs ()
-(NSString*)propertyToNode:(NSString*)field nodeName:(NSString*)name;
@end

@implementation LevelCaseArgs
-(NSString*)XmlSerialize{
    NSMutableString *xml=[NSMutableString stringWithFormat:@"<?xml version=\"1.0\"?>"];
    [xml appendString:@"<LevelCaseArgs xmlns=\"LevelCaseArgs\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">"];
   [xml appendString:[self toXmlString]];
    [xml appendString:[self propertyToNode:_GUID nodeName:@"GUID"]];
    [xml appendString:[self propertyToNode:_Level nodeName:@"Level"]];
    [xml appendString:[self propertyToNode:_CaseSettingGuid nodeName:@"CaseSettingGuid"]];
    [xml appendString:[self propertyToNode:_CityGuid nodeName:@"CityGuid"]];
    [xml appendString:[self propertyToNode:_Nick nodeName:@"Nick"]];
    if (_BApplyDate==nil) {
        [xml appendString:@"<BApplyDate xsi:nil=\"true\"/>"];
    }else{
       [xml appendFormat:@"<BApplyDate>%@</BApplyDate>",_BApplyDate];
    }
    if (_EApplyDate==nil) {
        [xml appendString:@"<EApplyDate xsi:nil=\"true\"/>"];
    }else{
        [xml appendFormat:@"<EApplyDate>%@</EApplyDate>",_EApplyDate];
    }
    [xml appendString:@"</LevelCaseArgs>"];
    return xml;
}
-(NSString*)propertyToNode:(NSString*)field nodeName:(NSString*)name{
    NSString *str=[self getPropertyValue:field];
    if ([str length]==0) {
        return @"";
    }
    return [NSString stringWithFormat:@"<%@>%@</%@>",name,str,name];
}
@end