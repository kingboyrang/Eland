//
//  aboutUSViewController.m
//  CaseSearch
//
//  Created by rang on 13-7-23.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "aboutUSViewController.h"
#import "RTLabel.h"
#import "UIColor+TPCategory.h"
#import "AboutScrollView.h"
@interface aboutUSViewController ()

@end

@implementation aboutUSViewController

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
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [imageView setImage:[UIImage imageNamed:@"systemcheckbg.jpg"]];
    [self.view addSubview:imageView];
    [imageView release];
    //tableCell.backgroundColor=[UIColor clearColor];
    
    CGRect rect=self.view.bounds;
    /**
    if (self.IOSSystemVersion>=7.0) {
        rect.origin.y=44;
    }
     **/
    
    AboutScrollView *scrollView=[[AboutScrollView alloc] initWithFrame:rect];
    [self.view addSubview:scrollView];
    [scrollView release];
    //[self.navigationItem setShadowTitle:@"關於我"];
    [self.navigationItem titleViewBackground];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
