//
//  UserSetViewController.m
//  CaseSearch
//
//  Created by rang on 13-7-23.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "UserSetViewController.h"
#import "TKLabelTextFieldCell.h"
#import "TKEmptyCell.h"
#import "UIColor+TPCategory.h"
#import "SecrecyViewController.h"
@interface UserSetViewController ()

@end

@implementation UserSetViewController
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
   
    [self.navigationItem resetNavigationBarBack];
   
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc] initWithTitle:@"存储" style:UIBarButtonItemStylePlain target:self action:@selector(buttonSaveClick)];
    self.navigationItem.rightBarButtonItem=rightBtn;
    [rightBtn release];
     [self.navigationItem setShadowTitle:@"使用者設定"];
    
    CGRect rect=self.view.bounds;
    
    _tableView=[[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundView=nil;
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setAutoresizesSubviews:YES];
    [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:_tableView];
    
    TKLabelTextFieldCell *cell1=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:@"姓名" required:NO];
    cell1.field.placeholder=@"editable name";
    
    TKLabelTextFieldCell *cell2=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell2 setLabelName:@"手機號碼" required:NO];
    cell2.field.placeholder=@"editable phone";
    
    TKLabelTextFieldCell *cell3=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
     [cell3 setLabelName:@"Email" required:NO];
    cell3.field.placeholder=@"editable Email";
    
    TKLabelTextFieldCell *cell4=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell4 setLabelName:@"暱稱" required:NO];
    cell4.field.placeholder=@"editable nick";
    
    
    self.cells =[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4, nil];
    
    self.view.backgroundColor=[UIColor colorFromHexRGB:@"dfdfdf"];
	// Do any additional setup after loading the view.
}
-(void)buttonSaveClick{

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        cell.textLabel.text=@"隱私及資訊安全保護政策";
        cell.textLabel.textColor=[UIColor colorFromHexRGB:@"666666"];
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.backgroundColor=[UIColor colorFromHexRGB:@"5cc2cb"];//a2dce1
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section==1&&indexPath.row==0){
        SecrecyViewController *secrecy=[[SecrecyViewController alloc] init];
        [self.navigationController pushViewController:secrecy animated:YES];
        [secrecy release];
    }
}
@end
