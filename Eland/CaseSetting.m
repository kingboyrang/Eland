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
-(NSString*)IconURLString{
    if (_Icon&&[_Icon length]>0) {
        return [_Icon stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
    }
    return @"";
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
@end
