//
//  Case.m
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "Case.h"
#import "GDataXMLNode.h"
#import "XmlParseHelper.h"
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
+(Case*)xmlStringToCase:(NSString*)xml{
    Case *entity=[[[Case alloc] init] autorelease];
    xml=[xml stringByReplacingOccurrencesOfString:@"xmlns=\"Case\"" withString:@""];
    XmlParseHelper *_parse=[[[XmlParseHelper alloc] init] autorelease];
    NSError *error=nil;
    GDataXMLDocument *document=[[GDataXMLDocument alloc] initWithXMLString:xml options:0 error:&error];
    GDataXMLElement* rootNode = [document rootElement];
    NSArray *rootChilds=[rootNode children];
    for (GDataXMLNode *item in rootChilds) {
        if ([item.name isEqualToString:@"Extend"]) {//扩展资料
            entity.Extend=[_parse childsNodeToObject:item objectName:@"CaseExtend"];
            continue;
        }
        if ([item.name isEqualToString:@"Applicant"]) {//申请人资料
            entity.Applicant=[_parse childsNodeToObject:item objectName:@"CaseApplicant"];
            continue;
        }
        if ([item.name isEqualToString:@"Images"]) {//案件图片资料
            entity.Images=[_parse nodesChildsNodesToObjects:item objectName:@"CaseImage"];
            continue;
        }
        if ([item.name isEqualToString:@"ApprovalImages"]) {//审核图片资料
            entity.Images=[_parse nodesChildsNodesToObjects:item objectName:@"CaseApprovalImage"];
            continue;
        }
        SEL sel=NSSelectorFromString(item.name);
        if ([entity respondsToSelector:sel]) {
            [entity setValue:[item stringValue] forKey:item.name];
        }
    }
    return entity;
}
@end
