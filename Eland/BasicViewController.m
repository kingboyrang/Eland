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
#import "AppDelegate.h"
#import "NetWorkConnection.h"
@interface BasicViewController (){
    AnimateLoadView *_loadView;
    AnimateErrorView *_errorView;
    UIButton *_gpsButton;
    UIButton *_netButton;
}
- (void)detectShowOrientation;
- (void)updateNetworkImage:(BOOL)isBoo;
- (void)addCheckBarButton;
- (void)updateGpsImage;
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
    if(_gpsButton){
        [_gpsButton release],_gpsButton=nil;
    }
    if(_netButton){
        [_netButton release],_netButton=nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
     //AppDelegate *delegated=[[UIApplication sharedApplication] delegate];
    //[delegated removeObserver:self forKeyPath:@"hasConnect"];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateGpsImage];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorFromHexRGB:@"F1F4F2"];
    [self addCheckBarButton];
    //横竖屏检测
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectShowOrientation) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    //网络检测
    AppDelegate *delegated=[[UIApplication sharedApplication] delegate];
    [delegated addObserver:self forKeyPath:@"hasConnect" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
	// Do any additional setup after loading the view.
}
-(float)IOSSystemVersion{
    NSString *version=[[UIDevice currentDevice] systemVersion];
    return [version floatValue];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addCheckBarButton{
    UIView *custom=[[UIView alloc] initWithFrame:CGRectZero];
    custom.backgroundColor=[UIColor clearColor];
    //gps
    UIImage *gpsImage=[UIImage imageNamed:@"gps_noraml.png"];
    _gpsButton=[[UIButton buttonWithType:UIButtonTypeCustom] retain];
    _gpsButton.frame=CGRectMake(0, 0, 35, 35);
    [_gpsButton setImage:gpsImage forState:UIControlStateNormal];
    [_gpsButton setImage:[UIImage imageNamed:@"gps_abnormal.png"] forState:UIControlStateSelected];
    [custom addSubview:_gpsButton];
    //net
    _netButton=[[UIButton buttonWithType:UIButtonTypeCustom] retain];
    _netButton.frame=CGRectMake(_gpsButton.frame.size.width, 0, 35, 35);
    [_netButton setImage:[UIImage imageNamed:@"net_noraml.png"] forState:UIControlStateNormal];
    [_netButton setImage:[UIImage imageNamed:@"net_abnormal.png"] forState:UIControlStateSelected];
    [custom addSubview:_netButton];
    //frame
    custom.frame=CGRectMake(0,(44-_netButton.frame.size.height)/2.0, _netButton.frame.size.width*2, _netButton.frame.size.height);
    
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc] initWithCustomView:custom];
    self.navigationItem.rightBarButtonItem=rightBtn;
    [custom release];
    [rightBtn release];
}
- (void)updateGpsImage{
    BOOL boo=[NetWorkConnection locationServicesEnabled];
    if (boo) {
        _gpsButton.selected=NO;
    }else{
        _gpsButton.selected=YES;
    }
}
- (void)updateNetworkImage:(BOOL)isBoo{
   
    if (isBoo) {
        _netButton.selected=NO;
    }else{
        _netButton.selected=YES;
    }
   
    
}
#pragma mark 横竖屏检测
-(void)detectShowOrientation{
    if ([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft ||[UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight){//
        _isLandscape=YES;
    }else{//
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
    WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"網絡錯誤" message:@"請檢查您的網絡連接."];
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
       NSNumber *number1=[change objectForKey:@"new"];
       NSNumber *number2=[change objectForKey:@"old"];
       if ([number1 boolValue]!=[number2 boolValue]) {
           _hasNetwork=[number1 boolValue];
           [self updateNetworkImage:_hasNetwork];
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
