//
//  MainViewController.m
//  active
//
//  Created by 徐 军 on 13-8-20.
//  Copyright (c) 2013年 chenjin. All rights reserved.
//

#import "MainViewController.h"
#import "UIColor+TPCategory.h"
#import "UIImage+TPCategory.h"
#import "IndexViewController.h"
#import "aboutUSViewController.h"
#import "SystemCheckViewController.h"
#import "UserSetViewController.h"
#import "BasicNagigationController.h"
#import "PushResult.h"
#import "PushDetailViewController.h"
//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define TABRHEIGHT 44 //工具栏高度
#define STATUSBARHEIGHT 20 //状态栏高度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
@interface MainViewController ()
-(void)updateTabBarViewFrame:(UIInterfaceOrientation)orientation;
-(void)updateSelectedStatus:(int)selectTag lastIndex:(int)prevIndex;
-(void)updateNavigatorFrame:(UIInterfaceOrientation)orientation;
@end

@implementation MainViewController
-(void)dealloc{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_tabbarView release];
    [_silderView release];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         [self.tabBar setHidden:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initViewController];//初始化子控制器
    [self _initTabbarView];//创建自定义tabBar
    
    //接收推播信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotifice:) name:kPushNotificeName object:nil];
}
-(void)receiveNotifice:(NSNotification*)notice{
    NSDictionary *dic=[notice userInfo];
    NSString *guid=[dic objectForKey:@"guid"];
    PushResult *entity=[PushResult PushResultWithGuid:guid];
    
    UINavigationController *nav=[self.viewControllers objectAtIndex:self.selectedIndex];
    if ([nav.topViewController isKindOfClass:[PushDetailViewController class]]) {
        PushDetailViewController *controller=(PushDetailViewController*)nav.topViewController;
        [controller loadPushDetail:guid];
    }else{
       PushDetailViewController *detail=[[PushDetailViewController alloc] init];
       detail.Entity=entity;
       [nav pushViewController:detail animated:YES];
       [detail release];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UI
//初始化子控制器
- (void)_initViewController {
    IndexViewController *index=[[[IndexViewController alloc] init] autorelease];
    BasicNagigationController *nav1=[[[BasicNagigationController alloc] initWithRootViewController:index] autorelease];
    nav1.delegate=self;

    UserSetViewController *userset=[[[UserSetViewController alloc] init] autorelease];
    BasicNagigationController *nav2=[[[BasicNagigationController alloc] initWithRootViewController:userset] autorelease];
    nav2.delegate=self;
    
    
    aboutUSViewController *aboutUs=[[[aboutUSViewController alloc] init] autorelease];
    BasicNagigationController *nav3=[[[BasicNagigationController alloc] initWithRootViewController:aboutUs] autorelease];
    nav3.delegate=self;
    
    SystemCheckViewController *system=[[[SystemCheckViewController alloc] init] autorelease];
    BasicNagigationController *nav4=[[[BasicNagigationController alloc] initWithRootViewController:system] autorelease];
    nav4.delegate=self;
    
    
    self.viewControllers = [NSArray arrayWithObjects:nav1,nav2,nav3,nav4, nil];
    
    //重设可见视图大小 
    UIView *transitionView =[[self.view subviews] objectAtIndex:0];
    CGRect frame=transitionView.frame;
    frame.size.height=ScreenHeight-TABRHEIGHT;
    frame.size.width=ScreenWidth;
    transitionView.frame=frame;
}

//创建自定义tabBar
- (void)_initTabbarView {
    _tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-TABRHEIGHT, ScreenWidth, TABRHEIGHT)];
    _tabbarView.backgroundColor=[UIColor colorFromHexRGB:@"272727"];
    _tabbarView.autoresizesSubviews=YES;
    _tabbarView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:_tabbarView];
    NSArray *backgroud = @[@"index_normal.png",@"user_normal.png",@"about_normal.png",@"system_normal.png"];
    NSArray *heightBackground = @[@"index_select.png",@"user_select.png",@"about_select.png",@"system_select.png"];
    CGFloat w=ScreenWidth/backgroud.count*1.0;
    
    //滑块
    _silderView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w, TABRHEIGHT)];
    [_silderView setImage:[UIImage createImageWithColor:[UIColor colorFromHexRGB:@"343434"]]];
    //_silderView.tag=999;
    [_tabbarView addSubview:_silderView];
    //总数
    _barButtonItemCount=[backgroud count];
    //
    _prevSelectIndex=0;
    
    for (int i=0; i<backgroud.count; i++) {
        NSString *backImage = backgroud[i];
        NSString *heightImage = heightBackground[i];
        UIImage *normal=[UIImage imageNamed:backImage];
        UIImage *hight=[UIImage imageNamed:heightImage];
        
        CGFloat leftX=i==0?(w-normal.size.width)/2:i*w+(w-normal.size.width)/2;
        UIButton *button =[[UIButton alloc] initWithFrame:CGRectMake(leftX, 0, normal.size.width, TABRHEIGHT)];
        [button setBackgroundImage:normal forState:UIControlStateNormal];
        [button setBackgroundImage:hight forState:UIControlStateSelected];
        button.tag = 100+i;
        if (i==0) {
            button.selected=YES;
        }
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        
       [_tabbarView addSubview:button];
        [button release];
    }
    
}

#pragma mark - actions
//tab 按钮的点击事件
- (void)selectedTab:(UIButton *)button {

    button.selected=YES;
    CGRect frame=_silderView.frame;
    frame.origin.x=(button.tag-100)*frame.size.width;
    [UIView animateWithDuration:0.2 animations:^{
        
        _silderView.frame=frame;
        [self updateSelectedStatus:button.tag-100 lastIndex:_prevSelectIndex];
    }];
    //判断是否是重复点击tab按钮
    if (button.tag == self.selectedIndex && button.tag == 0) {
       //[_homeCtrl autorefresh];
    }
    self.selectedIndex = button.tag-100;
    
    //重设布局
    if (self.selectedIndex==0) {
        UINavigationController *nav=(UINavigationController*)[self.viewControllers objectAtIndex:self.selectedIndex];
        IndexViewController *index=(IndexViewController*)[nav.viewControllers objectAtIndex:0];
        if (index) {
            //[index reSubViewLayout];
        }
    }
    
}
//是否隐藏tabbar
- (void)showTabbar:(BOOL)show {
    
}
#pragma mark - UINavigationController delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //viewController.hidesBottomBarWhenPushed=YES;
    //导航控制器子控制器的个数
    int count = navigationController.viewControllers.count;
    if (count == 1) {
        [self showTabbar:YES];
    }else if (count == 2) {
        [self showTabbar:NO];
    }
}
#pragma mark 旋转处理
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    
    [self updateNavigatorFrame:toInterfaceOrientation];
    [self updateTabBarViewFrame:toInterfaceOrientation];
}
#pragma mark 私有方法
-(void)updateSelectedStatus:(int)selectTag lastIndex:(int)prevIndex{
    UIButton *btn=(UIButton*)[_tabbarView viewWithTag:100+prevIndex];
    btn.selected=NO;
    _prevSelectIndex=selectTag;
}
-(void)updateTabBarViewFrame:(UIInterfaceOrientation)orientation{
    CGFloat transitionViewH,transitionViewW;
    UIView * transitionView =[[self.view subviews] objectAtIndex:0];
    if(UIInterfaceOrientationIsLandscape(orientation))
    {
        CGRect frame=_tabbarView.frame;
        frame.origin.y=ScreenWidth-TABRHEIGHT;
        frame.size.width=ScreenHeight;
        _tabbarView.frame=frame;
        
        
        transitionViewH=ScreenWidth-TABRHEIGHT;
        transitionViewW=ScreenHeight;
        
    }else{
        CGRect frame=_tabbarView.frame;
        frame.origin.y=ScreenHeight-TABRHEIGHT;
        frame.size.width=ScreenWidth;
        _tabbarView.frame=frame;
        
        transitionViewH=ScreenHeight-TABRHEIGHT;
        transitionViewW=ScreenWidth;
        
    }
    //重设self.tabBarController.view大小
    CGRect frame=transitionView.frame;
    frame.size.height=transitionViewH;
    frame.size.width=transitionViewW;
    transitionView.frame=frame;
    
    
    CGFloat w=_tabbarView.frame.size.width/4.0;
    //重设滑块大小
    frame=_silderView.frame;
    frame.size.width=w;
    frame.origin.x=self.selectedIndex*w;
    _silderView.frame=frame;
    //重设UIButton位置
    for (int i=0; i<_barButtonItemCount; i++) {
        id v=[_tabbarView viewWithTag:100+i];
        if([v isKindOfClass:[UIButton class]]){
            UIButton *btn=(UIButton*)v;
            frame=btn.frame;
            CGFloat leftX=i==0?(w-frame.size.width)/2:i*w+(w-frame.size.width)/2;
            frame.origin.x=leftX;
            btn.frame=frame;
        }
    }
}
-(void)updateNavigatorFrame:(UIInterfaceOrientation)orientation{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return;
    }
    if ([[self.viewControllers objectAtIndex:self.selectedIndex] isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav=(UINavigationController*)[self.viewControllers objectAtIndex:self.selectedIndex];
        CGRect frame=nav.navigationBar.frame;
        if(UIInterfaceOrientationIsLandscape(orientation)){//横屏
            frame.size.height=32.0;
        }else{
            frame.size.height=44.0;
        }
        nav.navigationBar.frame=frame;
    }
}
@end
