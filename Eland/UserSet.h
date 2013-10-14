//
//  appSet.h
//  CaseSearch
//
//  Created by rang on 13-4-22.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSet : NSObject<NSCoding>
@property(nonatomic,copy) NSString *GUID;//手机唯一码
@property(nonatomic,copy) NSString *Name;
@property(nonatomic,copy) NSString *Nick;
@property(nonatomic,copy) NSString *Mobile;
@property(nonatomic,copy) NSString *Email;
@property(nonatomic,copy) NSString *AppToken;//推播Token
@property(nonatomic,assign) BOOL isRegisterToken;//推播Token
@property(nonatomic,assign) BOOL isSync;//判断是否已同步
@property(nonatomic,assign) BOOL isFirstLoad;
@property(nonatomic,assign) BOOL isSecondLoad;
@property(nonatomic,assign) BOOL isReadPrivacy;//是否读取隐私权限
//单例模式
+ (UserSet *)sharedInstance;
- (void) save;
//读取隐私权限
- (void) readPrivacy;
//注册token
- (void) registerAppToken:(NSString*)token status:(BOOL)status;
//业务专区同步
+ (void) businessSync;
+ (NSString*)ObjectToXml;
@end