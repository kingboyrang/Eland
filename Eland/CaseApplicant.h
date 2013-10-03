//
//  CaseApplicant.h
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicModle.h"
@interface CaseApplicant : BasicModle
@property(nonatomic,copy) NSString *ID;

@property(nonatomic,copy) NSString *GUID;

@property(nonatomic,copy) NSString *CaseGuid;

@property(nonatomic,copy) NSString *Name;

@property(nonatomic,copy) NSString *Nick;

@property(nonatomic,copy) NSString *Phone;

@property(nonatomic,copy) NSString *Tel;

@property(nonatomic,copy) NSString *FaxTel;

@property(nonatomic,copy) NSString *Email;

@property(nonatomic,copy) NSString *Address;
-(NSString*)XmlSerialize;
@end
