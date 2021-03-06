//
//  CaseSetting.m
//  Eland
//
//  Created by aJia on 13/10/14.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseSetting.h"
#import "XmlParseHelper.h"
#import "GDataXMLNode.h"

@interface CaseSetting (){
    NSArray *_hrFields;
}
-(BOOL)existsArrayElement:(NSString*)name;
@end

@implementation CaseSetting
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.GUID forKey:@"GUID"];
    [encoder encodeObject:self.Name forKey:@"Name"];
    [encoder encodeObject:self.ShowCity forKey:@"ShowCity"];
    [encoder encodeObject:self.UpImg forKey:@"UpImg"];
    [encoder encodeObject:self.UpImgNum forKey:@"UpImgNum"];
    [encoder encodeObject:self.Icon forKey:@"Icon"];
    [encoder encodeObject:self.Memo forKey:@"Memo"];
    [encoder encodeObject:self.Fields forKey:@"Fields"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.GUID=[aDecoder decodeObjectForKey:@"GUID"];
        self.Name=[aDecoder decodeObjectForKey:@"Name"];
        self.ShowCity=[aDecoder decodeObjectForKey:@"ShowCity"];
        self.UpImg=[aDecoder decodeObjectForKey:@"UpImg"];
        self.UpImgNum=[aDecoder decodeObjectForKey:@"UpImgNum"];
        self.Icon=[aDecoder decodeObjectForKey:@"Icon"];
        self.Memo=[aDecoder decodeObjectForKey:@"Memo"];
        self.Fields=[aDecoder decodeObjectForKey:@"Fields"];
        
    }
    return self;
}
-(BOOL)showImage{
    if (_UpImg&&[_UpImg isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}
-(BOOL)showCityDown{
    if (_ShowCity&&[_ShowCity isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}
-(NSString*)IconURLString{
    if (_Icon&&[_Icon length]>0) {
        return [_Icon stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
    }
    return @"";
}
-(BOOL)isRequiredShowCity{
    if (self.Fields&&[self.Fields count]>0) {
        NSString *match=[NSString stringWithFormat:@"SELF.Name =='%@'",@"ShowCity"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:match];
        NSArray *results = [self.Fields filteredArrayUsingPredicate:predicate];
        if (results&&[results count]>0) {
            CaseSettingField *entity=[results objectAtIndex:0];
            return entity.isRequired;
        }

    }
    return NO;
}
-(NSArray*)sortFields{
    if (self.Fields&&[self.Fields count]>0) {
        NSComparator cmptr = ^(id obj1, id obj2){
            CaseSettingField *field1=(CaseSettingField*)obj1;
            CaseSettingField *field2=(CaseSettingField*)obj2;
            if ([field1.Sort integerValue] > [field2.Sort integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([field1.Sort integerValue] < [field2.Sort integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;  
        };
        //第一种排序
        return  [self.Fields sortedArrayUsingComparator:cmptr];
        
        
       // NSSortDescriptor *_sorter  = [[NSSortDescriptor alloc] initWithKey:@"Sort" ascending:YES];
       // NSArray *sortArr=[self.Fields sortedArrayUsingDescriptors:[NSArray arrayWithObjects:_sorter, nil]];
       // return sortArr;
    }
    return [NSArray array];
}
-(CaseSettingField*)getEntityFieldWithName:(NSString*)name{
    if (self.Fields&&[self.Fields count]>0) {
        NSString *match=[NSString stringWithFormat:@"SELF.Name =='%@'",name];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:match];
        NSArray *results = [self.Fields filteredArrayUsingPredicate:predicate];
        if (results&&[results count]>0) {
            CaseSettingField *entity=[results objectAtIndex:0];
            return entity;
        }
    }
    return nil;
}
+(CaseSetting*)xmlStringToCaseSetting:(NSString*)xml{
    CaseSetting *entity=[[[CaseSetting alloc] init] autorelease];
    
    xml=[xml stringByReplacingOccurrencesOfString:@"xmlns=\"CaseSetting\"" withString:@""];
    
    XmlParseHelper *_parse=[[[XmlParseHelper alloc] init] autorelease];
    NSError *error=nil;
    GDataXMLDocument *document=[[GDataXMLDocument alloc] initWithXMLString:xml options:0 error:&error];
    GDataXMLElement* rootNode = [document rootElement];
    NSArray *rootChilds=[rootNode children];
    for (GDataXMLNode *item in rootChilds) {
        if ([item.name isEqualToString:@"Fields"]) {//显示栏位
            NSArray *arr=[_parse nodesChildsNodesToObjects:item objectName:@"CaseSettingField"];
           
            //排序
            NSSortDescriptor *_sorter  = [[NSSortDescriptor alloc] initWithKey:@"Sort" ascending:YES];
            NSArray *sortArr=[arr sortedArrayUsingDescriptors:[NSArray arrayWithObjects:_sorter, nil]];
            entity.Fields=sortArr;
            [_sorter release];
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
+(NSArray*)xmlStringToCaseSettings:(NSString*)xml{
   xml=[xml stringByReplacingOccurrencesOfString:@"xmlns=\"CaseSetting[]\"" withString:@""];
   XmlParseHelper *_parse=[[[XmlParseHelper alloc] initWithData:xml] autorelease];
   return [_parse selectNodes:@"//CaseSetting" className:@"CaseSetting"];
}
-(BOOL)existsArrayElement:(NSString*)name{
    NSString *match=[NSString stringWithFormat:@"SELF =='%@'",name];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:match];
    NSArray *results = [_hrFields filteredArrayUsingPredicate:predicate];
    if (results&&[results count]>0) {
        
        return YES;
    }
    return NO;

}
-(BOOL)hrExistFieldName:(NSString*)name{
    if (!_hrFields) {
        NSString *path=[[NSBundle mainBundle] pathForResource:@"HRFields" ofType:@"plist"];
        _hrFields=[[NSArray arrayWithContentsOfFile:path] retain];
    }
    return [self existsArrayElement:name];
}
-(void)dealloc{
    [super dealloc];
    if (_hrFields) {
        //[_hrFields release];
    }
}
@end
