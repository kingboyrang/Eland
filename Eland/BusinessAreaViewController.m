//
//  BusinessAreaViewController.m
//  Eland
//
//  Created by rang on 13-9-29.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "BusinessAreaViewController.h"
#import "TKLabelTextFieldCell.h"
#import "TKLabelTextViewCell.h"
#import "TKEmptyCell.h"
#import "UIColor+TPCategory.h"
#import "UIDevice+TPCategory.h"
#import "UserSet.h"
#import "NSString+TPCategory.h"
@interface BusinessAreaViewController ()
-(void)buttonSyncClick;
-(BOOL)formSubmit;
-(void)checkSync;
@end

@implementation BusinessAreaViewController
@synthesize cells=_cells;
@synthesize tableView=_tableView;
-(void)dealloc{
    [super dealloc];
    [_tableView release],_tableView=nil;
    [_cells release],_cells=nil;
    [_serviceHelper release],_serviceHelper=nil;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    TKLabelTextViewCell *cell1=self.cells[0];
    cell1.textView.text=[[UserSet sharedInstance] AppToken];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _serviceHelper=[[ServiceHelper alloc] init];
    self.view.backgroundColor=[UIColor colorFromHexRGB:@"dfdfdf"];
    
    CGRect rect=self.view.bounds;
    _tableView=[[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundView=nil;
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setAutoresizesSubviews:YES];
    [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:_tableView];
    
    TKLabelTextViewCell *cell1=[[[TKLabelTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:@"APP憑證" required:NO];
    cell1.textView.editable=NO;
    cell1.textView.text=[[UserSet sharedInstance] AppToken];
    
    TKLabelTextFieldCell *cell2=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell2 setLabelName:@"狀態" required:NO];
    cell2.field.placeholder=@"editable status";
    cell2.field.userInteractionEnabled=NO;
    if ([[UserSet sharedInstance] isSync]) {
        cell2.field.text=@"已同步";
    }else{
        cell2.field.text=@"未同步";
        [self checkSync];//取得名称
    }
    
    TKLabelTextFieldCell *cell3=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell3 setLabelName:@"裝置名稱" required:NO];
    cell3.field.userInteractionEnabled=NO;
    cell3.field.text=@"IOS施政互動";
    
    TKLabelTextFieldCell *cell4=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell4 setLabelName:@"帳號" required:NO];
    cell4.field.placeholder=@"請輸入帳號";
    
    TKLabelTextFieldCell *cell5=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell5 setLabelName:@"密碼" required:NO];
    cell5.field.placeholder=@"請輸入密碼";
    cell5.field.secureTextEntry=YES;
    
    
    self.cells =[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4,cell5, nil];
    
	// Do any additional setup after loading the view.
    
    //4e8b9f229316617b2932743695a331589e0cdc8c42
}
-(void)checkSync{
    NSString *token=[[[UserSet sharedInstance] AppToken] Trim];
    if ([token length]>0) {
        ServiceArgs *args=[[[ServiceArgs alloc] init] autorelease];
        args.methodName=@"IsBindAccount";
        args.soapParams=[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:token,@"tokenGuid", nil], nil];
        [_serviceHelper asynService:args delegate:self];
    }
}
#pragma mark -
#pragma mark ServiceHelperDelegate Methods
-(void)finishSoapRequest:(ServiceResult*)result{
    
    if ([result.xmlString length]>0) {
        NSString *xml=[result.xmlString stringByReplacingOccurrencesOfString:result.xmlnsAttr withString:@""];
        [result.xmlParse setDataSource:xml];
        XmlNode *node=[result.xmlParse selectSingleNode:@"//IsBindAccountResult"];
        if ([node.Value isEqualToString:@"true"]) {
            TKLabelTextFieldCell *cell=self.cells[1];
            cell.field.text=@"已同步";
            [UserSet businessSync];
        }
    }
}
-(void)failedSoapRequest:(NSError*)error userInfo:(NSDictionary*)dic{
   
}
-(void)relayout:(BOOL)isLand{
    if (isLand) {
        _tableView.frame=CGRectMake(0, 0, DeviceHeight,DeviceWidth-44*2);
    }else{
        _tableView.frame=CGRectMake(0, 0, DeviceWidth,DeviceHeight-44*2-20);
    }
}
-(BOOL)formSubmit{
    TKLabelTextFieldCell  *cell3=self.cells[3];
    TKLabelTextFieldCell  *cell4=self.cells[4];
    if (![cell3 hasValue]) {
        [cell3 shake];
        return NO;
    }
    if (![cell4 hasValue]) {
        [cell4 shake];
        return NO;
    }
    return YES;
}
//同步
-(void)buttonSyncClick{
    if (![self formSubmit]) {
        return;
    }
    TKLabelTextFieldCell *cell2=self.cells[2];
    TKLabelTextFieldCell  *cell3=self.cells[3];
    TKLabelTextFieldCell  *cell4=self.cells[4];

    //[[UserSet sharedInstance] AppToken]
    NSMutableArray *params=[NSMutableArray array];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[UserSet sharedInstance] AppToken],@"tokenGuid", nil]];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:cell2.field.text,@"appName", nil]];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:cell3.field.text,@"uid", nil]];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:cell4.field.text,@"pwd", nil]];
    
    [self showLoadingStatus:@"正在同步..."];
    ServiceArgs *args=[[[ServiceArgs alloc] init] autorelease];
    args.methodName=@"AccountBinder";
    args.soapParams=params;
    [_serviceHelper asynService:args success:^(ServiceResult *result) {
        if (result.request.responseStatusCode==200) {
            NSString *xml=[result.xmlString stringByReplacingOccurrencesOfString:result.xmlnsAttr withString:@""];
            [result.xmlParse setDataSource:xml];
            XmlNode *resultNode=[result.xmlParse soapXmlSelectSingleNode:@"//AccountBinderResult"];
            xml=[resultNode.Value stringByReplacingOccurrencesOfString:@"xmlns=\"Result\"" withString:@""];
            [result.xmlParse setDataSource:xml];
            XmlNode *node=[result.xmlParse selectSingleNode:@"//Success"];
            if (node&&[node.Value isEqualToString:@"true"]) {
                [UserSet businessSync];
                TKLabelTextFieldCell *cell1=self.cells[1];
                cell1.field.text=@"已同步";
                [self showLoadingFailedStatus:@"同步成功!"];
            }else{
                [self showLoadingFailedStatus:@"同步失敗!"];
            }
            
        }else{
          [self showLoadingFailedStatus:@"同步失敗!"];
        }
        
    } failed:^(NSError *error, NSDictionary *userInfo) {
        [self showLoadingFailedStatus:@"同步失敗!"];
    }];
    
}
#pragma mark UITableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return self.cells.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        UITableViewCell *tableCell=self.cells[indexPath.row];
        if (indexPath.row!=0||indexPath.row!=2) {
            tableCell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        return tableCell;
    }else{
        TKEmptyCell *cell=[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text=@"同步";
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.backgroundColor=[UIColor colorFromHexRGB:@"5e5e5e"];//a2dce1
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        return DeviceIsPad?44.0:120;
    }
    return 44.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section==1&&indexPath.row==0){
        [self buttonSyncClick];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark Rotation

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
@end
