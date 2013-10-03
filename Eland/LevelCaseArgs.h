//
//  LevelCaseArgs.h
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchArgs.h"
@interface LevelCaseArgs : SearchArgs
@property(nonatomic,copy) NSString *GUID;
@property(nonatomic,copy) NSString *Level;
@property(nonatomic,copy) NSString *CaseSettingGuid;
@property(nonatomic,copy) NSString *CityGuid;
@property(nonatomic,copy) NSString *Nick;
@property(nonatomic,copy) NSString *Status;
@property(nonatomic,copy) NSString *BApplyDate;
@property(nonatomic,copy) NSString *EApplyDate;
-(NSString*)XmlSerialize;
@end
