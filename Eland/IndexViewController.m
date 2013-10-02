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
}
- (void)addSearch:(int)tag;
@end

@implementation IndexViewController
-(void)dealloc{
    [super dealloc];
    [_menuBar release],_menuBar=nil;
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
    _menuBar=[[MenuBar alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, h)];
    _menuBar.controlers=self;
    _menuBar.autoresizesSubviews=YES;
    _menuBar.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_menuBar];
    
   RepairItemViewController *_repair=[[RepairItemViewController alloc] init];
   CaseSearchViewController *_caseSearch=[[CaseSearchViewController alloc] init];
   PushViewController *_push=[[PushViewController alloc] init];
   BusinessAreaViewController *_business=[[BusinessAreaViewController alloc] init];
    [self addChildViewController:_repair];
    [self addChildViewController:_caseSearch];
    [self addChildViewController:_push];
    [self addChildViewController:_business];
    /***
    NSString *path=[DocumentPath stringByAppendingPathComponent:@"back.png"];
    UIImage *image=[[UIImage imageNamed:@"back.png"] imageByScalingProportionallyToSize:CGSizeMake(116*35/49, 35)];
    [image saveImage:path];
    NSLog(@"path=%@\n",path);
     ***/
}
- (void)handChangePageIndex:(int)index{
    [_menuBar setSelectedItemIndex:index];
}
-(void)selectedMenuItemIndex:(int)index{
    [self changePageIndex:index];
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
