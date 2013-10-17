//
//  CaseAddViewController.m
//  Eland
//
//  Created by aJia on 13/10/17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseAddViewController.h"
#import "ASIHTTPRequest.h"
@interface CaseAddViewController ()
-(void)loadingFormFields;
@end

@implementation CaseAddViewController

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
	
}
-(void)loadingFormFields{
    NSString *url=[NSString stringWithFormat:SingleCaseSettingURL,self.Entity.GUID];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [request setCompletionBlock:^{
        if (request.responseStatusCode==200) {
            self.Entity=[CaseSetting xmlStringToCaseSetting:request.responseString];
        }
    }];
    [request setFailedBlock:^{
        
    }];
    [request startAsynchronous];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
