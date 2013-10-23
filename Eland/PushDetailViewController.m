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
@interface PushDetailViewController (){
    UILabel *_labTitle;
    UITextView *_textView;
}
-(void)showErrorView;
-(void)updateUIShow;
@end

@implementation PushDetailViewController
-(void)dealloc{
    [super dealloc];
    [_labTitle release],_labTitle=nil;
    [_textView release],_textView=nil;
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
    _labTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
	_labTitle.backgroundColor=[UIColor colorFromHexRGB:@"dfdfdf"];
    _labTitle.font=[UIFont boldSystemFontOfSize:16];
    _labTitle.textColor=[UIColor colorFromHexRGB:@"3DB5C0"];
    [self.view addSubview:_labTitle];
    
    _textView=[[UITextView alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height-40)];
    _textView.editable=NO;
    _textView.backgroundColor=[UIColor colorFromHexRGB:@"f4f4f4"];
    _textView.textColor=[UIColor blackColor];
    _textView.font=[UIFont boldSystemFontOfSize:16];
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
    CGSize size=[self.Entity.Subject textSize:[UIFont boldSystemFontOfSize:16] withWidth:self.view.bounds.size.width];
    CGRect frame=_labTitle.frame;
    frame.size.height=size.height;
    if (size.height<40) {
        frame.size.height=40;
    }
    _labTitle.frame=frame;
    _labTitle.text=self.Entity.Subject;
    
    frame=_textView.frame;
    frame.origin.y=_labTitle.frame.size.height;
    frame.size.height=self.view.bounds.size.height-_labTitle.frame.size.height;
    _textView.frame=frame;
    _textView.text=self.Entity.Body;
}
-(void)showErrorView{
    WBErrorNoticeView *errorView=[WBErrorNoticeView errorNoticeInView:self.view title:@"提示" message:@"資料加載失敗!"];
    [errorView show];
}
-(void)loadPushDetail:(NSString*)guid{
    ServiceArgs *args=[[[ServiceArgs alloc] init] autorelease];
    args.methodName=@"GetMessage";
    args.soapParams=[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:guid,@"guid", nil], nil];
    
    [ServiceHelper asynService:args success:^(ServiceResult *result) {
        if ([result.xmlString length]>0) {
            NSString *xml=[result.xmlString stringByReplacingOccurrencesOfString:result.xmlnsAttr withString:@""];
            [result.xmlParse setDataSource:xml];
            XmlNode *node=[result.xmlParse soapXmlSelectSingleNode:@"//GetMessageResult"];
            xml=[node.Value stringByReplacingOccurrencesOfString:@"xmlns=\"PushResult\"" withString:@""];
            [result.xmlParse setDataSource:xml];
            NSArray *arr=[result.xmlParse selectNodes:@"//Entity" className:@"PushResult"];
            if ([arr count]>0) {
                self.Entity=[arr objectAtIndex:0];
                [CacheHelper cacheCasePushResult:self.Entity];
                [self updateUIShow];
            }else{
               [self showErrorView];
            }
        }else{
            [self showErrorView];
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
