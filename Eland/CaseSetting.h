//
//  CaseSetting.h
//  Eland
//
//  Created by aJia on 13/10/14.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CaseSettingField.h"
@interface CaseSetting : NSObject<NSCoding>
@property(nonatomic,copy) NSString *GUID;
@property(nonatomic,copy) NSString *Name;
@property(nonatomic,copy) NSString *ShowCity;
@property(nonatomic,copy) NSString *UpImg;
@property(nonatomic,copy) NSString *UpImgNum;
@property(nonatomic,copy) NSString *Icon;
@property(nonatomic,copy) NSString *Memo;
@property(nonatomic,strong) NSArray *Fields;

@property(nonatomic,readonly) BOOL showImage;
@property(nonatomic,readonly) BOOL showCityDown;
@property(nonatomic,readonly) NSString *IconURLString;
@property(nonatomic,readonly) NSArray *sortFields;

+(CaseSetting*)xmlStringToCaseSetting:(NSString*)xml;
+(NSArray*)xmlStringToCaseSettings:(NSString*)xml;
//乡镇市是否必填
-(BOOL)isRequiredShowCity;
//获取一项设定
-(CaseSettingField*)getEntityFieldWithName:(NSString*)name;

-(BOOL)hrExistFieldName:(NSString*)name;
@end
