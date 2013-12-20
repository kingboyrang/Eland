//
//  CaseApproval.h
//  Eland
//
//  Created by aJia on 2013/12/20.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaseApproval : NSObject
@property(nonatomic,copy) NSString *ID;//自動增長
@property(nonatomic,copy) NSString *GUID;//主鍵
@property(nonatomic,copy) NSString *CaseGuid;//案件編號
@property(nonatomic,copy) NSString *Signer;//審核人
@property(nonatomic,copy) NSString *SignDate;//審核日期
@property(nonatomic,copy) NSString *SignSource;//審核來源
@property(nonatomic,copy) NSString *IsSMS;//是否發送簡訊
@property(nonatomic,copy) NSString *SignMemo;//項目辦理情形
@property(nonatomic,copy) NSString *OtherUrl;//當前案件第三方查看URL
@property(nonatomic,copy) NSString *Created;//創建日期

@end
