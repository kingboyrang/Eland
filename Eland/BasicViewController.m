//
//  BasicViewController.m
//  Eland
//
//  Created by aJia on 13/9/10.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "BasicViewController.h"
#import "WBErrorNoticeView.h"
#import "WBSuccessNoticeView.h"
#import "UIColor+TPCategory.h"
@interface BasicViewController (){
    AnimateLoadView *_loadView;
    AnimateErrorView *_errorView;
}
-(void)detectShowOrientation;
@end

@implementation BasicViewController
@synthesize hasNetwork=_hasNetwork;
@synthesize isPad;
@synthesize isLandscape=_isLandscape;
-(void)dealloc{
    [super dealloc];
    if(_loadView){
        [_loadView release],_loadView=nil;
    }
    if(_errorView){
        [_errorView release],_errorView=nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorFromHexRGB:@"F1F4F2"];
    //网络检测
    [[UIApplication sharedApplication] addObserver:self forKeyPath:@"hasConnect" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    //横竖屏检测
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectShowOrientation) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 横竖屏检测
-(void)detectShowOrientation{
    if ([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft ||[UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight){//
        //NSLog(@"videolist 横屏");
        _isLandscape=YES;
    }else{//
        //NSLog(@"videoList 竖屏");
        _isLandscape=NO;
    }
}
#pragma mark 属性重写
-(BOOL)isPad{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        return YES;
    }
    return NO;
}
#pragma mark 网络未连接提示
- (void) showNoNetworkNotice:(void (^)(void))dismissError{
    WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"Network Error" message:@"Check your network connection."];
    [notice setDismissalBlock:^(BOOL dismissedInteractively) {
        if (dismissError) {
            dismissError();
        }
    }];
    [notice show];
}
- (void) showSuccessNoticeWithTitle:(NSString*)title{
    WBSuccessNoticeView *notice = [WBSuccessNoticeView successNoticeInView:self.view title:title];
    [notice show];
}
#pragma mark 网络检测
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
   if([keyPath isEqualToString:@"hasConnect"])
   {
       if (![[change objectForKey:@"new"] isEqualToString:[change objectForKey:@"old"]]) {
           NSNumber *number=[change objectForKey:@"new"];
           _hasNetwork=[number boolValue];
       }
   }
}
#pragma mark 动画提示
-(AnimateErrorView*) errorView {
    
    if (!_errorView) {
        _errorView=[[AnimateErrorView alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
        
    }
    return _errorView;
}

-(AnimateLoadView*) loadingView {
    if (!_loadView) {
        _loadView=[[AnimateLoadView alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
        
    }
    return _loadView;
}

-(void) showLoadingAnimated:(BOOL) animated process:(void (^)(AnimateLoadView *showView))process{
    
    AnimateLoadView *loadingView = [self loadingView];
    if (process) {
        process(loadingView);
    }
    loadingView.alpha = 0.0f;
    [self.view addSubview:loadingView];
    [self.view bringSubviewToFront:loadingView];
    
    double duration = animated ? 0.4f:0.0f;
    [UIView animateWithDuration:duration animations:^{
        loadingView.alpha = 1.0f;
    }];
}

-(void) hideLoadingViewAnimated:(BOOL) animated completed:(void (^)(AnimateLoadView *hideView))complete{
    
    AnimateLoadView *loadingView = [self loadingView];
    
    double duration = animated ? 0.4f:0.0f;
    [UIView animateWithDuration:duration animations:^{
        loadingView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [loadingView removeFromSuperview];
        if (complete) {
            complete(loadingView);
        }
    }];
}

-(void) showErrorViewAnimated:(BOOL) animated process:(void (^)(AnimateErrorView *errView))process{
    
    AnimateErrorView *errorView = [self errorView];
    if (process) {
        process(errorView);
    }
    errorView.alpha = 0.0f;
    [self.view addSubview:errorView];
    [self.view bringSubviewToFront:errorView];
    
    double duration = animated ? 0.4f:0.0f;
    [UIView animateWithDuration:duration animations:^{
        errorView.alpha = 1.0f;
    }];
}

-(void) hideErrorViewAnimated:(BOOL) animated completed:(void (^)(AnimateErrorView *errView))complete{
    
    AnimateErrorView *errorView = [self errorView];
    
    double duration = animated ? 0.4f:0.0f;
    [UIView animateWithDuration:duration animations:^{
        errorView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [errorView removeFromSuperview];
        if (complete) {
            complete(errorView);
        }
    }];
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    
    CGRect screnRect=self.view.bounds;
    CGFloat screenW=screnRect.size.width,screenH=screnRect.size.height;
    if (_loadView) {
        CGRect frame=_loadView.frame;
        frame.origin.x=(screenW-frame.size.width)/2.0;
        frame.origin.y=(screenH-frame.size.height)/2.0;
        _loadView.frame=frame;
    }
    if (_errorView) {
        CGRect frame=_errorView.frame;
        frame.origin.x=(screenW-frame.size.width)/2.0;
        frame.origin.y=(screenH-frame.size.height)/2.0;
        _errorView.frame=frame;
    }
}
#pragma mark 加载状态
- (void)showLoadingStatus:(NSString*)title{
    [ZAActivityBar showWithStatus:title];
}
- (void)showLoadingSuccessStatus:(NSString*)title{
    [ZAActivityBar showSuccessWithStatus:title];
}
- (void)showLoadingFailedStatus:(NSString*)title{
    [ZAActivityBar showErrorWithStatus:title];
}
- (void)hideLoadingStatus{
    [ZAActivityBar dismiss];
}
@end
