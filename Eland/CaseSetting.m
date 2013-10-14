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
-(BOOL)showImage{
    if (_UpImg&&[_UpImg isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
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
    return entity;
}
@end
