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
#import "RepairItemViewController.h"
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
    CGFloat h=self.isPad?58:40;
    _menuBar=[[MenuBar alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, h)];
    _menuBar.autoresizesSubviews=YES;
    _menuBar.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_menuBar];
   
    RepairItemViewController *repair=[[RepairItemViewController alloc] init];
    repair.view.frame=CGRectMake(0, h, self.view.bounds.size.width, self.view.bounds.size.height-h);
    [self addChildViewController:repair];
    [self.view addSubview:repair.view];
     
    
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
#pragma mark -
#pragma mark Rotation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
@end
