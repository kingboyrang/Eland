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
@interface SystemCheckViewController ()
- (void)buttonLocation:(id)sender;
- (void)buttonCompare;
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
    
    BOOL is3G=[NetWorkConnection IsEnable3G];
    TKButtonLabelCell *cell1=[[[TKButtonLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1.button setTitle:@"WIFI 3G:" forState:UIControlStateNormal];
    [cell1 setLabelValue:is3G?@"開啟":@"未開啟" normal:is3G];
    
    BOOL isConnection=[NetWorkConnection IsEnableConnection];
    TKButtonLabelCell *cell2=[[[TKButtonLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell2.button setTitle:@"Internet:" forState:UIControlStateNormal];
    [cell2 setLabelValue:isConnection?@"正常連接":@"連接異常" normal:isConnection];
    
    TKButtonLabelCell *cell3=[[[TKButtonLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell3.button setTitle:@"施政互動:" forState:UIControlStateNormal];
    
    self.checkcells =[NSMutableArray arrayWithObjects:cell1,cell2,cell3, nil];
    
    
    
    TKButtonLabelCell *cell4=[[[TKButtonLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell4.button setTitle:@"A點:" forState:UIControlStateNormal];
    [cell4.button addTarget:self action:@selector(buttonLocation:) forControlEvents:UIControlEventTouchUpInside];
    
    TKButtonLabelCell *cell5=[[[TKButtonLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell5.button setTitle:@"B點:" forState:UIControlStateNormal];
    [cell5.button addTarget:self action:@selector(buttonLocation:) forControlEvents:UIControlEventTouchUpInside];
    
    TKButtonLabelCell *cell6=[[[TKButtonLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell6.button setTitle:@"測試結果:" forState:UIControlStateNormal];
    [cell6.button addTarget:self action:@selector(buttonCompare) forControlEvents:UIControlEventTouchUpInside];
    
    self.checkcells =[NSMutableArray arrayWithObjects:cell1,cell2,cell3, nil];
    self.gpscells =[NSMutableArray arrayWithObjects:cell4,cell5,cell6, nil];
    
    //[self.navigationItem setShadowTitle:@"系統檢查"];
    [self.navigationItem titleViewBackground];
}
- (void)buttonLocation:(id)sender{
    UIButton *btn=(UIButton*)sender;
    TKButtonLabelCell *cell=(TKButtonLabelCell*)[[btn superview] superview];
    [cell startLocation];
}
- (void)buttonCompare{
    TKButtonLabelCell *cell1=self.gpscells[0];
    TKButtonLabelCell *cell2=self.gpscells[1];
    TKButtonLabelCell *cell3=self.gpscells[2];
    if ([cell1.label.text isEqualToString:cell2.label.text]) {
        [cell3 setLabelValue:@"定位正常" normal:YES];
    }else{
       [cell3 setLabelValue:@"定位異常" normal:NO];
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

	UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 30)];
	lab.text = section==0?@"網絡檢查:":@"定位檢定:";
	lab.backgroundColor = [UIColor clearColor];
	lab.textAlignment = NSTextAlignmentCenter;
    //lab.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
	
	[tempview addSubview:lab];
	
	[lab release];
	
	return tempview;
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
        NSLog(@"frame=%@\n",NSStringFromCGRect(frame));
    }else{
       self.tableView.bounces=NO;
        self.tableView.frame=self.view.bounds;
    }
}
@end
