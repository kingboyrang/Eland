//
//  IndexViewController.m
//  CaseSearch
//
//  Created by rang on 13-7-23.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "IndexViewController.h"
#import "AppDelegate.h"
#import "MenuBar.h"
#import "UIColor+TPCategory.h"
#import "UIImage+TPCategory.h"
@interface IndexViewController (){
    MenuBar *_menuBar;
    CaseSearchViewController *_caseSearch;
    
}
- (void)addSearch:(int)tag;
@end

@implementation IndexViewController
-(void)dealloc{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_menuBar release],_menuBar=nil;
    [_caseSearch release],_caseSearch=nil;
   
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
    [self.navigationItem titleViewBackground];
    CGFloat h=DeviceIsPad?58:40;
    //CGFloat topY=self.IOSSystemVersion>=7.0?44.0:0.0;
    CGFloat topY=0.0;
    _menuBar=[[MenuBar alloc] initWithFrame:CGRectMake(0, topY, DeviceWidth, h)];
    _menuBar.controlers=self;
    _menuBar.autoresizesSubviews=YES;
    _menuBar.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_menuBar];
    
   
   
   RepairItemViewController *_repair=[[[RepairItemViewController alloc] init] autorelease];
   _caseSearch=[[CaseSearchViewController alloc] init];
   PushViewController *_push=[[[PushViewController alloc] init] autorelease];
   BusinessAreaViewController *_business=[[[BusinessAreaViewController alloc] init] autorelease];
    [self addChildViewController:_repair];
    [self addChildViewController:_caseSearch];
    [self addChildViewController:_push];
    [self addChildViewController:_business];
    
    
     
    
    //[self.view bringSubviewToFront:_menuBar];
  
   /***
    NSString *path=[DocumentPath stringByAppendingPathComponent:@"arrow_right.png"];
    UIImage *image=[[UIImage imageNamed:@"arrow_down.png"] imageRotatedByDegrees:-90];
    [image saveImage:path];
    NSLog(@"path=%@\n",path);
    
    NSString *path1=[DocumentPath stringByAppendingPathComponent:@"ipad_load@2x.png"];
    UIImage *image1=[UIImage imageNamed:@"ipad_load@2x.jpg"];
    [image1 saveImage:path1];
    
    ***/
    /***
    NSString *path2=[DocumentPath stringByAppendingPathComponent:@"Default-568h@2x.png"];
    UIImage *image2=[UIImage imageNamed:@"wel.jpg"];
    [image2 saveImage:path2];
    ***/
    
}





/***
- (void)handChangePageIndex:(int)index{
    [_menuBar setSelectedItemIndex:index];
    if (index==1) {
        [_caseSearch loadingSource];
    }
}
 **/
-(void)selectedMenuItemIndex:(int)index{
    [self changePageIndex:index];
    if (index==1) {
        [_caseSearch loadingSource];
    }
}
- (void)addSearch:(int)tag{
    if (tag==1) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, 0, 30, 30);
        [btn setBackgroundImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
        UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.rightBarButtonItem=rightBtn;
        [rightBtn release];
    }else{
        self.navigationItem.rightBarButtonItem=nil;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
