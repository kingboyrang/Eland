//
//  Account.h
//  Eland
//
//  Created by aJia on 13/9/10.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject
@property(nonatomic,copy) NSString *Name;
@property(nonatomic,copy) NSString *Nick;
@property(nonatomic,copy) NSString *Mobile;
@property(nonatomic,copy) NSString *Email;
@property(nonatomic,copy) NSString *AppToken;
@property(nonatomic,assign) BOOL isLogin;
@end
