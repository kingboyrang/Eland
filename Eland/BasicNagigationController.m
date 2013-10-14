//
//  BasicNagigationController.m
//  Eland
//
//  Created by aJia on 13/10/2.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "BasicNagigationController.h"

@interface BasicNagigationController ()
-(UIBarButtonItem*)customLeftBackButton;
-(void)popself;
@end

@implementation BasicNagigationController

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
	// Do any additional setup after loading the view.
}
-(void)popself
{
    [self popViewControllerAnimated:YES];
}

-(UIBarButtonItem*)customLeftBackButton{
    UIImage *image=[UIImage imageNamed:@"back.png"];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, image.size.width, image.size.height);
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return backItem;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (![self.topViewController isKindOfClass:[viewController class]]) {
        [super pushViewController:viewController animated:animated];
    }
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1){
        viewController.navigationItem.leftBarButtonItem =[self customLeftBackButton];
    }
    
}

@end
