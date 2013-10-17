//
//  CaseSettingField.h
//  Eland
//
//  Created by aJia on 13/10/14.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaseSettingField : NSObject
@property(nonatomic,copy) NSString *CaseSettingGuid;
@property(nonatomic,copy) NSString *GUID;
@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *Label;
@property(nonatomic,copy) NSString *Name;
@property(nonatomic,copy) NSString *Required;
@property(nonatomic,copy) NSString *Sort;
@property(nonatomic,copy) NSString *Text;
//是否必填
@property(nonatomic,readonly) BOOL isRequired;
//
-(BOOL)isTextArea;
@end
