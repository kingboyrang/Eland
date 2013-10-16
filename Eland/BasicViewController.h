//
//  BasicViewController.h
//  Eland
//
//  Created by aJia on 13/9/10.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimateLoadView.h"
#import "AnimateErrorView.h"
#import "ZAActivityBar.h"
@interface BasicViewController : UIViewController
@property(nonatomic,readonly) BOOL hasNetwork;
@property(nonatomic,readonly) BOOL isPad;
@property(nonatomic,readonly) BOOL isLandscape;
@property(nonatomic,readonly) float IOSSystemVersion;
//动画操作
-(AnimateErrorView*) errorView;
-(AnimateLoadView*) loadingView;
-(void) showLoadingAnimated:(BOOL) animated process:(void (^)(AnimateLoadView *showView))process;
-(void) hideLoadingViewAnimated:(BOOL) animated completed:(void (^)(AnimateLoadView *hideView))complete;
-(void) showErrorViewAnimated:(BOOL) animated process:(void (^)(AnimateErrorView *errorView))process;
-(void) hideErrorViewAnimated:(BOOL) animated completed:(void (^)(AnimateErrorView *errorView))complete;
//网络提示
- (void) showNoNetworkNotice:(void (^)(void))dismissError;
- (void) showSuccessNoticeWithTitle:(NSString*)title;
//加载状态
- (void)showLoadingStatus:(NSString*)title;
- (void)showLoadingSuccessStatus:(NSString*)title;
- (void)showLoadingFailedStatus:(NSString*)title;
- (void)hideLoadingStatus;
@end
