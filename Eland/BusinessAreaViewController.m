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
@interface BusinessAreaViewController ()

@end

@implementation BusinessAreaViewController
@synthesize cells=_cells;
@synthesize tableView=_tableView;
-(void)dealloc{
    [super dealloc];
    [_tableView release],_tableView=nil;
    [_cells release],_cells=nil;
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
    cell1.textView.userInteractionEnabled=NO;
    cell1.textView.text=[[UIDevice currentDevice] uniqueDeviceIdentifier];
    
    TKLabelTextFieldCell *cell2=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell2 setLabelName:@"狀態" required:NO];
    cell2.field.placeholder=@"editable status";
    
    TKLabelTextFieldCell *cell3=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell3 setLabelName:@"裝置名稱" required:NO];
    cell3.field.enabled=NO;
    cell3.field.text=@"施政互動";
    
    TKLabelTextFieldCell *cell4=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell4 setLabelName:@"帳號" required:NO];
    cell4.field.placeholder=@"editable account";
    
    TKLabelTextFieldCell *cell5=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell5 setLabelName:@"密碼" required:NO];
    cell5.field.placeholder=@"editable pwd";
    
    
    self.cells =[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4,cell5, nil];
	// Do any additional setup after loading the view.
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
        cell.textLabel.textColor=[UIColor colorFromHexRGB:@"666666"];
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.backgroundColor=[UIColor colorFromHexRGB:@"5cc2cb"];//a2dce1
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        return 65.0;
    }
    return 44.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section==1&&indexPath.row==0){
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
