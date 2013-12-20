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
#import "CaseCategoryHelper.h"
#import "CaseCategory.h"
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
    [xml appendFormat:@"<ApplyDate>%@</ApplyDate>",[self getPropertyValue:_ApplyDate]];
    [xml appendFormat:@"<AppCode>%@</AppCode>",[self getPropertyValue:_AppCode]];
    if (_Extend!=nil) {
        [xml appendString:[_Extend XmlSerialize]];
    }
    if (_Applicant!=nil) {
        [xml appendString:[_Applicant XmlSerialize]];
    }
    if (_Images!=nil&&[_Images count]>0) {
        [xml appendString:@"<Images>"];
        for (CaseImage *item in _Images) {
            [xml appendString:[item XmlSerialize]];
        }
        [xml appendString:@"</Images>"];
    }
    [xml appendString:@"</Case>"];
    return xml;
}
-(NSArray*)imageURLs{
    if (self.Images&&[self.Images count]>0) {
        NSMutableArray *arr=[NSMutableArray array];
        for (CaseImage *item in self.Images) {
            NSString *url=[NSString stringWithFormat:CaseImageViewURL,item.Path];
            [arr addObject:url];
        }
        return arr;
    }
    return nil;
}
-(NSString*)StatusText{
    if (_Status&&[_Status length]>0) {
        if ([_Status isEqualToString:@"1"]) return @"辦理中";
        if ([_Status isEqualToString:@"2"]) return @"已完成";
        if ([_Status isEqualToString:@"3"]) return @"已刪除";
    }
    return @"";
}
-(NSString*)CaseCagegoryName{
    NSMutableArray *arr=[NSMutableArray array];
    if (_CaseSettingGuid&&[_CaseSettingGuid length]>0) {
        CaseCategory *entity1=[CaseCategoryHelper getCaseCategoryEntity:_CaseSettingGuid];
        if (entity1!=nil) {
            [arr addObject:entity1.Name];
        }
    }
    if (_CaseCagegory1&&[_CaseCagegory1 length]>0) {
        CaseCategory *entity2=[CaseCategoryHelper getCaseCategoryEntity:_CaseCagegory1];
        if (entity2!=nil) {
            [arr addObject:entity2.Name];
        }
    }
    if (_CaseCagegory2&&[_CaseCagegory2 length]>0) {
        CaseCategory *entity3=[CaseCategoryHelper getCaseCategoryEntity:_CaseCagegory2];
        if (entity3!=nil) {
            [arr addObject:entity3.Name];
        }
    }
    if ([arr count]>0) {
        return [arr componentsJoinedByString:@">"];
    }
    return @"";
}
-(NSString*)ApplyDateText{
    if (_ApplyDate&&[_ApplyDate length]>0) {
        return [_ApplyDate stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    }
    return @"";
}
-(NSString*)HandlerMemo{
    NSMutableString *str=[NSMutableString stringWithString:@""];
    if(_Approval&&_Approval.SignMemo&&[_Approval.SignMemo length]>0)
        [str appendString:_Approval.SignMemo];
    if (_Status&&[_Status length]>0&&[_Status isEqualToString:@"1"]) {
        [str appendString:@"案件已送交，由負責人員辦理中"];
    }
    if ([str length]>0) {
        return str;
    }
    return @"案件已送交，由負責人員辦理中";
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
        if ([item.name isEqualToString:@"Approval"]) {//审核资料
            entity.Approval=[_parse childsNodeToObject:item objectName:@"CaseApproval"];
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
    [document release];
    return entity;
}
-(NSString*)getFieldValue:(NSString*)propertyname{
    if ([propertyname isEqualToString:@"Images"]||[propertyname isEqualToString:@"ApprovalImages"]) {
        return @"";
    }
    if ([propertyname isEqualToString:@"LngLat"]&&self.Extend) {
        return [NSString stringWithFormat:@"%@~%@",self.Extend.Lng,self.Extend.Lat];
    }
    SEL sel=NSSelectorFromString(propertyname);
    if ([self respondsToSelector:sel]) {//判断是否响应这个属性
        return [self valueForKey:propertyname];
    }
    if (self.Extend&&[self.Extend respondsToSelector:sel]) {
        return [self.Extend valueForKey:propertyname];
    }
    if (self.Applicant&&[self.Applicant respondsToSelector:sel]) {
        return [self.Applicant valueForKey:propertyname];
    }
    return @"";
}
-(void)objectValue:(id)value objectKey:(NSString *)name{
    SEL sel=NSSelectorFromString(name);
    if ([self respondsToSelector:sel]) {
        [self setValue:value forKey:name];
    }else if([self.Extend respondsToSelector:sel]){
        [self.Extend setValue:value forKey:name];
    }else if([self.Applicant respondsToSelector:sel]){
        [self.Applicant setValue:value forKey:name];
    }else{
    
    }
}
@end
