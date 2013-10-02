//
//  CaseSearchViewController.m
//  Eland
//
//  Created by rang on 13-9-29.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseSearchViewController.h"
#import "SearchField.h"
@interface CaseSearchViewController ()

@end

@implementation CaseSearchViewController

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
    
    SearchField *field=[[SearchField alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44*3)];
    field.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:field];
    [field release];
	// Do any additional setup after loading the view.
}
-(void)relayout:(BOOL)isLand{

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
