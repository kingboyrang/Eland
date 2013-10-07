//
//  LevelCase.h
//  Eland
//
//  Created by aJia on 13/10/7.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicModle.h"
@interface LevelCase : BasicModle
@property(nonatomic,copy) NSString *PKey;
@property(nonatomic,copy) NSString *GUID;
@property(nonatomic,copy) NSString *Level;
@property(nonatomic,copy) NSString *PWD;
@property(nonatomic,copy) NSString *CaseSettingGuid;
@property(nonatomic,copy) NSString *Nick;
@property(nonatomic,copy) NSString *ApplyDate;
@property(nonatomic,copy) NSString *Status;
@property(nonatomic,copy) NSString *CityGuid;
-(NSString*)formatDataTw;
-(NSString*)StatusText;
-(NSString*)CategoryName;
@end
