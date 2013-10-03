//
//  LevelCaseArgs.m
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "LevelCaseArgs.h"



@implementation LevelCaseArgs
-(NSString*)XmlSerialize{
    NSMutableString *xml=[NSMutableString stringWithFormat:@"<?xml version=\"1.0\"?>"];
    [xml appendString:@"<LevelCaseArgs xmlns=\"LevelCaseArgs\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">"];
   [xml appendString:[self toXmlString]];
    
    [xml appendFormat:@"<GUID>%@</GUID>",[self getPropertyValue:_GUID]];
    [xml appendFormat:@"<Level>%@</Level>",[self getPropertyValue:_Level]];
    [xml appendFormat:@"<CaseSettingGuid>%@</CaseSettingGuid>",[self getPropertyValue:_CaseSettingGuid]];
    [xml appendFormat:@"<CityGuid>%@</CityGuid>",[self getPropertyValue:_CityGuid]];
    [xml appendFormat:@"<Nick>%@</Nick>",[self getPropertyValue:_Nick]];
    [xml appendFormat:@"<Status>%@</Status>",[self getPropertyValue:_Status]];
    
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
@end