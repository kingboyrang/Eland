//
//  AppDelegate.h
//  Eland
//
//  Created by aJia on 13/9/10.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,assign) BOOL hasConnect;//网络
@property(nonatomic,assign) BOOL isLandscape;//是否横屏
@end
