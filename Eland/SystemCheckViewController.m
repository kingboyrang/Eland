//
//  SystemCheckViewController.m
//  Eland
//
//  Created by aJia on 13/9/17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "SystemCheckViewController.h"
#import "TKLabelTextFieldCell.h"
#import "TKButtonLabelCell.h"
#import "UIColor+TPCategory.h"
#import "NetWorkConnection.h"
#import "TKCheckLabelCell.h"
#import "TKCheckButtonCell.h"
@interface SystemCheckViewController ()
- (void)buttonLocation:(id)sender;
- (void)buttonCompare;
- (void)addNetSorce;
- (void)addGpsSorce;
- (void)checkNetConnection;
- (void)checkGPSConnection;
@end

@implementation SystemCheckViewController
@synthesize checkcells=_checkcells;
@synthesize gpscells=_gpscells;
@synthesize tableView=_tableView;
-(void)dealloc{
    [super dealloc];
    [_tableView release],_tableView=nil;
    [_checkcells release],_checkcells=nil;
    [_gpscells release],_gpscells=nil;
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

    [self checkNetConnection];
    [self checkGPSConnection];
    
}
- (void)checkNetConnection{
    BOOL is3G=[NetWorkConnection IsEnable3G];
    TKCheckLabelCell *cell1=(TKCheckLabelCell*)self.checkcells[0];
    [cell1 setLabelValue:is3G?@"開啟":@"未開啟" normal:is3G];
    
    BOOL isConnection=[NetWorkConnection IsEnableConnection];
    TKCheckLabelCell *cell2=(TKCheckLabelCell*)self.checkcells[1];
    [cell2 setLabelValue:isConnection?@"正常連接":@"連接異常" normal:isConnection];
    
    BOOL isEland=[NetWorkConnection isEnabledAccessURL:CityDownURL];
    TKCheckLabelCell *cell3=(TKCheckLabelCell*)self.checkcells[2];
    [cell3 setLabelValue:isEland?@"正常連接":@"連接異常" normal:isEland];
    
    BOOL isPush=[NetWorkConnection isEnabledAccessURL:PushWebserviceURL];
    TKCheckLabelCell *cell4=(TKCheckLabelCell*)self.checkcells[3];
    [cell4 setLabelValue:isPush?@"正常連接":@"連接異常" normal:isPush];
}
- (void)checkGPSConnection{
    BOOL is3G=[NetWorkConnection locationServicesEnabled];
    TKCheckLabelCell *cell1=(TKCheckLabelCell*)self.gpscells[0];
    [cell1 setLabelValue:is3G?@"開啟":@"未開啟" normal:is3G];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rect=self.view.bounds;    
    UIImageView *imageview = [[[UIImageView alloc] initWithFrame:self.view.bounds] autorelease];
    [imageview setImage:[UIImage imageNamed:@"systemcheckbg.jpg"]];
    
    
    _tableView=[[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundView=imageview;
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setAutoresizesSubviews:YES];
    [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.bounces=NO;
    [self.view addSubview:_tableView];
    
   
    [self addNetSorce];
    [self addGpsSorce];
    //[self.navigationItem setShadowTitle:@"系統檢查"];
    [self.navigationItem titleViewBackground];
}
- (void)addGpsSorce{
    TKCheckLabelCell *cell1=[[[TKCheckLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell1.leftLabel.text=@"1.先檢查GPS狀態:";
    
    TKCheckLabelCell *cell2=[[[TKCheckLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.leftLabel.text=@"2.做A點定位";
    
    TKCheckButtonCell *cell3=[[[TKCheckButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell3.button setTitle:@"A點" forState:UIControlStateNormal];
    [cell3.button addTarget:self action:@selector(buttonLocation:) forControlEvents:UIControlEventTouchUpInside];
    cell3.label.text=@"未定位";
    
    TKCheckLabelCell *cell4=[[[TKCheckLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell4.leftLabel.text=@"3.往任一方向移動50公尺";
    
    
    TKCheckLabelCell *cell5=[[[TKCheckLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell5.leftLabel.text=@"4.做B點定位";
    
    TKCheckButtonCell *cell6=[[[TKCheckButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell6.button setTitle:@"B點:" forState:UIControlStateNormal];
    [cell6.button addTarget:self action:@selector(buttonLocation:) forControlEvents:UIControlEventTouchUpInside];
     cell6.label.text=@"未定位";
    
    TKButtonLabelCell *cell7=[[[TKButtonLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell7.button setTitle:@"測試結果:" forState:UIControlStateNormal];
    [cell7.button setTitleColor:[UIColor colorFromHexRGB:@"3DB5C0"] forState:UIControlStateNormal];
    [cell7.button addTarget:self action:@selector(buttonCompare) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.gpscells =[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4,cell5,cell6,cell7, nil];

}
- (void)addNetSorce{
    
    TKCheckLabelCell *cell1=[[[TKCheckLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell1.leftLabel.text=@"WIFI 3G:";
    cell1.leftLabel.textColor=[UIColor colorFromHexRGB:@"3DB5C0"];
   
    
   
    TKCheckLabelCell *cell2=[[[TKCheckLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.leftLabel.text=@"Internet:";
    cell2.leftLabel.textColor=[UIColor colorFromHexRGB:@"3DB5C0"];
    
    
    
    TKCheckLabelCell *cell3=[[[TKCheckLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell3.leftLabel.text=@"施政互動:";
    cell3.leftLabel.textColor=[UIColor colorFromHexRGB:@"3DB5C0"];
   
    
    
    TKCheckLabelCell *cell4=[[[TKCheckLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell4.leftLabel.text=@"推播中心:";
    cell4.leftLabel.textColor=[UIColor colorFromHexRGB:@"3DB5C0"];
   
    
    self.checkcells =[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4, nil];

}
- (void)buttonLocation:(id)sender{
    UIButton *btn=(UIButton*)sender;
    TKCheckButtonCell *cell1=self.gpscells[2];
    TKCheckButtonCell *cell2=self.gpscells[5];
    TKButtonLabelCell *cell3=self.gpscells[6];

    TKCheckButtonCell *cell=[cell1.contentView.subviews containsObject:btn]?self.gpscells[2]:self.gpscells[5];
    [cell startLocation:^(BOOL finished) {
        if (finished) {
            if (![cell1.label.text isEqualToString:@"未定位"]&&![cell2.label.text isEqualToString:@"未定位"]) {
                if ([cell1.label.text isEqualToString:cell2.label.text]) {
                    [cell3 setLabelValue:@"定位正常" normal:YES];
                }else{
                    [cell3 setLabelValue:@"定位異常" normal:NO];
                }
            }
        }
    }];
}
- (void)buttonCompare{
    TKCheckButtonCell *cell1=self.gpscells[2];
    TKCheckButtonCell *cell2=self.gpscells[5];
    TKButtonLabelCell *cell3=self.gpscells[6];
    if (![cell1.label.text isEqualToString:@"未定位"]&&![cell2.label.text isEqualToString:@"未定位"]) {
       if ([cell1.label.text isEqualToString:cell2.label.text]) {
         [cell3 setLabelValue:@"定位正常" normal:YES];
       }else{
        [cell3 setLabelValue:@"定位異常" normal:NO];
       }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableView Delegate & DataSource
//定义分区的标题
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	//设置标题显示的视图
	UIView *tempview = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)]autorelease];
	[tempview setBackgroundColor:[UIColor colorFromHexRGB:@"fbab09"]];
    tempview.autoresizingMask=UIViewAutoresizingFlexibleWidth;

	UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 30)];
	lab.text = section==0?@"網絡檢查:":@"定位檢定:";
	lab.backgroundColor = [UIColor clearColor];
	lab.textAlignment = NSTextAlignmentCenter;
    //lab.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
	
	[tempview addSubview:lab];
	
	[lab release];
	
	return tempview;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==1) {
        if(indexPath.row==2||indexPath.row==5||indexPath.row==6)return 40.0;
    }
    return 30;
}
//指定标题的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return self.checkcells.count;
    }
    return self.gpscells.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        UITableViewCell *tableCell=self.checkcells[indexPath.row];
      
        if (indexPath.row!=0||indexPath.row!=2) {
            tableCell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        return tableCell;
    }else{
        UITableViewCell *tableCell=self.gpscells[indexPath.row];
        UIView *tempView = [[[UIView alloc] init] autorelease];
        tableCell.backgroundView=tempView;
        tableCell.backgroundColor=[UIColor clearColor];
        if (indexPath.row!=0||indexPath.row!=2) {
            tableCell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        return tableCell;
    }
}
#pragma mark 旋转处理
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    CGRect screenRect=[[UIScreen mainScreen] bounds];
    if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation)){//竖屏
        
       self.tableView.bounces=YES;
        CGRect frame=self.tableView.frame;
        frame.size.height=screenRect.size.height-20-32-44;
        self.tableView.frame=frame;
    }else{
       self.tableView.bounces=NO;
        self.tableView.frame=self.view.bounds;
    }
}
@end
