//
//  CaseDetailViewController.m
//  Eland
//
//  Created by aJia on 13/10/7.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseDetailViewController.h"
#import "ASIHTTPRequest.h"
#import "Case.h"
#import "WBInfoNoticeView.h"
@interface CaseDetailViewController ()
-(void)loadAsyncDetail;
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
    //[self.navigationItem titleViewBackground];
    [self loadAsyncDetail];
    //guid=1020089,pwd=1234
    
	// Do any additional setup after loading the view.
}
-(void)loadAsyncDetail{
    NSString *webURL=[NSString stringWithFormat:SingleCaseURL,self.itemCase.GUID,self.itemCase.PWD];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:webURL]];
    [request setCompletionBlock:^{
        if (request.responseStatusCode==200) {
            //NSLog(@"xml=%@\n",[Case xmlStringToCase:request.responseString]);
        }else{
            WBInfoNoticeView *info=[WBInfoNoticeView infoNoticeInView:self.view title:@"沒有返回數據!"];
            [info show];
        }
    }];
    [request setFailedBlock:^{
        WBInfoNoticeView *info=[WBInfoNoticeView infoNoticeInView:self.view title:@"服務請求未響應!"];
        [info show];
    }];
    [request startAsynchronous];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
