//
//  CaseDetailViewController.m
//  Eland
//
//  Created by aJia on 13/10/7.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseDetailViewController.h"

@interface CaseDetailViewController ()

@end

@implementation CaseDetailViewController
@synthesize itemCase=_itemCase;
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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
