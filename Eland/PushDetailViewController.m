//
//  PushDetailViewController.m
//  Eland
//
//  Created by aJia on 13/10/9.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "PushDetailViewController.h"
#import "ServiceHelper.h"
#import "WBErrorNoticeView.h"
#import "CacheHelper.h"
#import "UIColor+TPCategory.h"
#import "NSString+TPCategory.h"
#import "ShowPushDetail.h"
@interface PushDetailViewController (){
    UILabel *_labTitle;
    ShowPushDetail *_textView;
}
-(void)showErrorView;
-(void)updateUIShow;
@end

@implementation PushDetailViewController
-(void)dealloc{
    [super dealloc];
    [_labTitle release],_labTitle=nil;
    [_helper release];
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
    _helper=[[ServiceHelper alloc] init];
    _labTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
	_labTitle.backgroundColor=[UIColor colorFromHexRGB:@"dfdfdf"];
    _labTitle.font=[UIFont boldSystemFontOfSize:16];
    _labTitle.textColor=[UIColor colorFromHexRGB:@"3DB5C0"];
    _labTitle.numberOfLines=0;
    _labTitle.lineBreakMode=NSLineBreakByWordWrapping;
    _labTitle.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_labTitle];
    
    _textView=[[ShowPushDetail alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height-40)];
    [self.view addSubview:_textView];
    
    if (self.Entity) {
        if (![self.Entity.Subject isEqual:[NSNull null]]&&[self.Entity.Subject length]>0) {
            [self updateUIShow];
        }else{
            [self loadPushDetail:self.Entity.GUID];
        }
    }
}
-(void)updateUIShow{
    CGSize size=[self.Entity.Subject textSize:_labTitle.font withWidth:self.view.bounds.size.width];
    CGRect frame=_labTitle.frame;
    if (size.height>40) {
        frame.size.height=size.height;
        _labTitle.frame=frame;
    }
    _labTitle.text=self.Entity.Subject;
    
    frame=_textView.frame;
    frame.origin.y=_labTitle.frame.size.height;
    frame.size.height=self.view.bounds.size.height-_labTitle.frame.size.height;
    _textView.frame=frame;
    
    [_textView setTextContent:self.Entity.Body];
}
-(void)showErrorView{
    [ZAActivityBar dismissForAction:@"pushdetail"];
    WBErrorNoticeView *errorView=[WBErrorNoticeView errorNoticeInView:self.view title:@"提示" message:@"訊息加載失敗!"];
    [errorView show];
}
-(void)loadPushDetail:(NSString*)guid{
    [ZAActivityBar showWithStatus:@"正在加載..." forAction:@"pushdetail"];
    ServiceArgs *args=[[[ServiceArgs alloc] init] autorelease];
    args.methodName=@"GetMessage";
    args.soapParams=[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:guid,@"guid", nil], nil];
    [_helper asynService:args success:^(ServiceResult *result) {
        [ZAActivityBar dismissForAction:@"pushdetail"];
        BOOL boo=NO;
        NSString *memo=@"訊息加載失敗!";
        if ([result.xmlString length]>0) {
            NSString *xml=[result.xmlString stringByReplacingOccurrencesOfString:result.xmlnsAttr withString:@""];
            [result.xmlParse setDataSource:xml];
            XmlNode *node=[result.xmlParse soapXmlSelectSingleNode:@"//GetMessageResult"];
            xml=[node.Value stringByReplacingOccurrencesOfString:@"xmlns=\"PushResult\"" withString:@""];
            [result.xmlParse setDataSource:xml];
            NSArray *arr=[result.xmlParse selectNodes:@"//Entity" className:@"PushResult"];
            if ([arr count]>0) {
                boo=YES;
                self.Entity=[arr objectAtIndex:0];
                [CacheHelper cacheCasePushResult:self.Entity];
                [self updateUIShow];
            }else{
                NSArray *errors=[result.xmlParse selectNodes:@"//string"];
                if (errors&&[errors count]>0) {
                    memo=[[errors objectAtIndex:0] objectForKey:@"text"];
                }
            }
        }
        if (!boo) {
            WBErrorNoticeView *errorView=[WBErrorNoticeView errorNoticeInView:self.view title:@"提示" message:memo];
            [errorView show];
        }
    } failed:^(NSError *error, NSDictionary *userInfo) {
        [self showErrorView];
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
