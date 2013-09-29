//
//  secrecy 	 secrecy 	 secrecy 	 secrecy SecrecyViewController.m
//  CaseSearch
//
//  Created by rang on 13-7-26.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "SecrecyViewController.h"
#import "MainViewController.h"
#import "UserSetViewController.h"
#import "UserSet.h"
@interface SecrecyViewController ()

@end

@implementation SecrecyViewController

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
    if (self.tabBarController==nil) {
        [self.navigationItem titleViewBackground];
        UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc] initWithTitle:@"確認" style:UIBarButtonItemStyleBordered target:self action:@selector(buttonClick)];
        self.navigationItem.rightBarButtonItem=rightBtn;
        [rightBtn release];
    }
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Privacy" ofType:@"txt"];
    NSString *content=[[[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] autorelease];
    
    
    CGFloat h=self.view.bounds.size.height;
    UITextView *textView=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,h)];
    textView.backgroundColor=[UIColor clearColor];
    textView.text=content;
    textView.editable=NO;
    [textView setFont:[UIFont fontWithName:@"Verdana" size:16]];
    textView.textColor=[UIColor colorWithRed:110/255.0 green:106/255.0 blue:97/255.0 alpha:1];
    [textView setAutoresizesSubviews:YES];
    [textView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
    [self.view addSubview:textView];
    [textView release];
    
    // Do any additional setup after loading the view.
}
-(void)buttonClick{
    [[UserSet sharedInstance] readPrivacy];
    MainViewController *main=[[MainViewController alloc] init];
    main.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:main animated:YES completion:nil];
    [main release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
