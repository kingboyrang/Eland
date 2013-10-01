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
@interface IndexViewController ()
- (void)addSearch:(int)tag;
@end

@implementation IndexViewController
-(void)dealloc{
    [super dealloc];
   
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
    
    /***
    UIView *topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 44)];
    topView.backgroundColor=[UIColor colorFromHexRGB:@"3db5c0"];
    topView.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:topView];
    [topView release];
     ***/
    MenuBar *menu=[[MenuBar alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 40)];
    menu.autoresizesSubviews=YES;
    menu.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:menu];
    [menu release];
    
    
        
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

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
@end
