//
//  Case.m
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "Case.h"



@implementation Case
-(NSString*)XmlSerialize{
   NSMutableString *xml=[NSMutableString stringWithFormat:@"<?xml version=\"1.0\"?>"];
    [xml appendString:@"<Case xmlns=\"Case\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">"];
    [xml appendFormat:@"<PWD>%@</PWD>",[self getPropertyValue:_PWD]];
    [xml appendFormat:@"<CaseSettingGuid>%@</CaseSettingGuid>",[self getPropertyValue:_CaseSettingGuid]];
    [xml appendFormat:@"<CaseCagegory1>%@</CaseCagegory1>",[self getPropertyValue:_CaseCagegory1]];
    [xml appendFormat:@"<CaseCagegory2>%@</CaseCagegory2>",[self getPropertyValue:_CaseCagegory2]];
    [xml appendFormat:@"<CityGuid>%@</CityGuid>",[self getPropertyValue:_CityGuid]];
    [xml appendFormat:@"<Source>%@</Source>",[self getPropertyValue:_Source]];
    [xml appendFormat:@"<AppCode>%@</AppCode>",[self getPropertyValue:_AppCode]];
    if (_Extend!=nil) {
        [xml appendString:[_Extend XmlSerialize]];
    }
    if (_Applicant!=nil) {
        [xml appendString:[_Applicant XmlSerialize]];
    }
    if (_Images!=nil&&[_Images count]>0) {
        for (CaseImage *item in _Images) {
            [xml appendString:[item XmlSerialize]];
        }
    }
    [xml appendString:@"</Case>"];
    return xml;
}
@end
