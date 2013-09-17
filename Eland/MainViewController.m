//
//  MainViewController.m
//  CaseSearch
//
//  Created by rang on 13-7-25.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "MainViewController.h"
#import "IndexViewController.h"
#import "aboutUSViewController.h"
#import "UserSetViewController.h"
#import "SystemCheckViewController.h"
#import "UIColor+TPCategory.h"
@interface MainViewController ()
-(void)loadControls;
@end

@implementation MainViewController

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
    [self loadControls];
    
    //UIImage *image=[[UIImage imageNamed:@"arrow_down@2x.png"] imageRotatedByDegrees:-90];
    //[self saveImage:image withName:@"arrow_down@2x.png"];
}

-(void)loadControls{
   
    
    //110,178,5
    IndexViewController *index=[[[IndexViewController alloc] init] autorelease];
    [index.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"index_select.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"index_normal.png"]];
    UINavigationController *nav1=[[[UINavigationController alloc] initWithRootViewController:index] autorelease];
    
    
    UserSetViewController *userSet=[[[UserSetViewController alloc] init] autorelease];
    //userSet.title=@"使用者設定";
    
    [userSet.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"user_select.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"user_normal.png"]];
    UINavigationController *nav2=[[[UINavigationController alloc] initWithRootViewController:userSet] autorelease];
    
    aboutUSViewController *aboutUS=[[[aboutUSViewController alloc] init] autorelease];
    //aboutUS.title=@"關於我";
    [aboutUS.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"about_select.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"about_normal.png"]];
    UINavigationController *nav3=[[[UINavigationController alloc] initWithRootViewController:aboutUS] autorelease];
    
    
    SystemCheckViewController *systemCheck=[[[SystemCheckViewController alloc] init] autorelease];
    //systemCheck.title=@"系統檢查";
    [systemCheck.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"system_select.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"system_normal.png"]];
    UINavigationController *nav4=[[[UINavigationController alloc] initWithRootViewController:systemCheck] autorelease];
    
    [self setViewControllers:[NSArray arrayWithObjects:nav1,nav2,nav3,nav4, nil]];
    
    
    
   
    UIView *bgView=[[[UIView alloc] initWithFrame:self.tabBar.bounds] autorelease];
    bgView.backgroundColor=[UIColor colorFromHexRGB:@"272727"];
    [bgView setAutoresizesSubviews:YES];
    [bgView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [self.tabBar insertSubview:bgView atIndex:1];
    self.tabBar.opaque=YES;
    
     

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
