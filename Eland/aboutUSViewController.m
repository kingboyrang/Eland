//
//  aboutUSViewController.m
//  CaseSearch
//
//  Created by rang on 13-7-23.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "aboutUSViewController.h"
#import "RTLabel.h"
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
   
    NSString *path=[[NSBundle mainBundle] pathForResource:@"aboutUs" ofType:@"txt"];
    NSString *content=[[[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] autorelease];
    RTLabel *label=[[RTLabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-44)];
    label.autoresizesSubviews=YES;
    label.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.pagingEnabled=YES;
    scrollView.autoresizesSubviews=YES;
    scrollView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    scrollView.backgroundColor=[UIColor clearColor];
    [scrollView addSubview:label];
    [label setText:content];
    CGRect frame=label.frame;
    frame.size.height=label.optimumSize.height+120;
    label.frame=frame;
    [scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, label.optimumSize.height)];
    
    
    [self.view addSubview:scrollView];
    [label release];
    [content release];
    [scrollView release];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
