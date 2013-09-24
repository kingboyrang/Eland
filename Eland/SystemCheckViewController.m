//
//  SystemCheckViewController.m
//  Eland
//
//  Created by aJia on 13/9/17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "SystemCheckViewController.h"
#import "TKLabelTextFieldCell.h"
#import "UIColor+TPCategory.h"
@interface SystemCheckViewController ()

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
    
    _tableView=[[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundView=nil;
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setAutoresizesSubviews:YES];
    [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.bounces=NO;
    [self.view addSubview:_tableView];
    
    
    TKLabelTextFieldCell *cell1=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:@"WIFI 3G:" required:NO];
    cell1.field.enabled=NO;
    
    TKLabelTextFieldCell *cell2=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell2 setLabelName:@"Internet:" required:NO];
    cell2.field.enabled=NO;
    
    TKLabelTextFieldCell *cell3=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell3 setLabelName:@"施政互動:" required:NO];
    cell3.field.enabled=NO;
    
    self.checkcells =[NSMutableArray arrayWithObjects:cell1,cell2,cell3, nil];
    
    
    
    TKLabelTextFieldCell *cell4=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell4 setLabelName:@"A點:" required:NO];
    cell4.field.enabled=NO;
    
    TKLabelTextFieldCell *cell5=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell5 setLabelName:@"B點:" required:NO];
    cell5.field.enabled=NO;
    
    TKLabelTextFieldCell *cell6=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell6 setLabelName:@"測試結果:" required:NO];
    cell6.field.enabled=NO;
    
    self.checkcells =[NSMutableArray arrayWithObjects:cell1,cell2,cell3, nil];
    self.gpscells =[NSMutableArray arrayWithObjects:cell4,cell5,cell6, nil];
    //cell1.field.placeholder=@"editable name";
    
	// Do any additional setup after loading the view.
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
	UIView *tempview = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)]autorelease];
	[tempview setBackgroundColor:[UIColor colorFromHexRGB:@"fbab09"]];

	UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 30)];
	lab.text = section==0?@"網絡檢查:":@"定位檢定:";
	lab.backgroundColor = [UIColor clearColor];
	lab.textAlignment = NSTextAlignmentCenter;
	
	
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
        if (indexPath.row!=0||indexPath.row!=2) {
            tableCell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        return tableCell;
    }
}
@end
