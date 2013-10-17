//
//  CaseSettingField.m
//  Eland
//
//  Created by aJia on 13/10/14.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseSettingField.h"

@implementation CaseSettingField
-(BOOL)isRequired{
    if (_Required&&[_Required isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}
-(BOOL)isTextArea{
    if (_Name&&([_Name isEqualToString:@"Location"]||[_Name isEqualToString:@"Description"]||[_Name isEqualToString:@"Memo"])) {
        return YES;
    }
    return NO;
}
@end
