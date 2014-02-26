//
//  Case.h
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicModle.h"
#import "CaseExtend.h"
#import "CaseApplicant.h"
#import "CaseImage.h"
#import "CaseApproval.h"
@interface Case : BasicModle
@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *GUID;
@property(nonatomic,copy) NSString *PWD;
@property(nonatomic,copy) NSString *CaseSettingGuid;
@property(nonatomic,copy) NSString *CaseCagegory1;
@property(nonatomic,copy) NSString *CaseCagegory2;
@property(nonatomic,copy) NSString *CityGuid;
@property(nonatomic,copy) NSString *IsInterfacing;
@property(nonatomic,copy) NSString *OtherGuid;
@property(nonatomic,copy) NSString *Status;
@property(nonatomic,copy) NSString *Created;
@property(nonatomic,copy) NSString *ApplyDate;
@property(nonatomic,copy) NSString *ExpireDate;
@property(nonatomic,copy) NSString *Source;
@property(nonatomic,copy) NSString *AppCode;
@property(nonatomic,strong) CaseExtend *Extend;
@property(nonatomic,strong) CaseApplicant *Applicant;
@property(nonatomic,strong) CaseApproval *Approval;
@property(nonatomic,strong) NSArray *Images;
@property(nonatomic,strong) NSArray *ApprovalImages;

@property(nonatomic,readonly) NSString *StatusText;//状态
@property(nonatomic,readonly) NSString *CaseCagegoryName;//项目分类名称
@property(nonatomic,readonly) NSString *ApplyDateText;//通报日期
@property(nonatomic,readonly) NSString *HandlerMemo;//办理情形
@property(nonatomic,readonly) int HRType;
-(NSString*)XmlSerialize;
+(Case*)xmlStringToCase:(NSString*)xml;
-(NSString*)getFieldValue:(NSString*)propertyname;
-(NSString*)getCaseFieldValue:(NSString*)fieldName;
-(NSArray*)imageURLs;

-(void)objectValue:(id)value objectKey:(NSString*)name;
@end
