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
#import "UserSet.h"
#import "WBSuccessNoticeView.h"
#import "TKButtonButtonCell.h"
@interface UserSetViewController ()
-(void)buttonSaveClick;
-(void)buttonSecrecyClick;
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
   
    [self.navigationItem titleViewBackground];
     //[self.navigationItem setShadowTitle:@"使用者設定"];
    
    CGRect rect=self.view.bounds;
    
    _tableView=[[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundView=nil;
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setAutoresizesSubviews:YES];
    [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:_tableView];
    
    UserSet *entity=[UserSet sharedInstance];
    
    TKLabelTextFieldCell *cell1=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:@"姓名" required:NO];
    cell1.field.placeholder=@"editable name";
    if ([entity.Name length]>0) {
        cell1.field.text=entity.Name;
    }
    
    TKLabelTextFieldCell *cell2=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell2 setLabelName:@"手機號碼" required:NO];
    cell2.field.placeholder=@"editable phone";
    if ([entity.Mobile length]>0) {
        cell2.field.text=entity.Mobile;
    }
    
    TKLabelTextFieldCell *cell3=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
     [cell3 setLabelName:@"Email" required:NO];
    cell3.field.placeholder=@"editable Email";
    if ([entity.Email length]>0) {
        cell3.field.text=entity.Email;
    }
    
    TKLabelTextFieldCell *cell4=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell4 setLabelName:@"暱稱" required:NO];
    cell4.field.placeholder=@"editable nick";
    if ([entity.Nick length]>0) {
        cell4.field.text=entity.Nick;
    }
    
    self.cells =[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4, nil];
    
    self.view.backgroundColor=[UIColor colorFromHexRGB:@"dfdfdf"];
	// Do any additional setup after loading the view.
}
-(void)buttonSaveClick{
    if (isSubmit) {
        return;
    }
    isSubmit=YES;
    TKLabelTextFieldCell *cell1=(TKLabelTextFieldCell*)[self.cells objectAtIndex:0];
    if (!cell1.hasValue) {
        //[cell1 errorVerify];
        [cell1 shake];
        return;
    }
    TKLabelTextFieldCell *cell2=(TKLabelTextFieldCell*)[self.cells objectAtIndex:1];
    if (!cell2.hasValue) {
        //[cell2 errorVerify];
        [cell2 shake];
        return;
    }
    TKLabelTextFieldCell *cell3=(TKLabelTextFieldCell*)[self.cells objectAtIndex:2];
    if (!cell3.hasValue) {
        //[cell3 errorVerify];
        [cell3 shake];
        return;
    }
    TKLabelTextFieldCell *cell4=(TKLabelTextFieldCell*)[self.cells objectAtIndex:3];
    if (!cell4.hasValue) {
        //[cell4 errorVerify];
        [cell4 shake];
        return;
    }
    UserSet *user=[UserSet sharedInstance];
    user.Name=cell1.field.text;
    user.Mobile=cell2.field.text;
    user.Email=cell3.field.text;
    user.Nick=cell4.field.text;
    [user save];
    WBSuccessNoticeView *successView=[WBSuccessNoticeView successNoticeInView:self.view title:@"存儲成功!"];
    [successView setDismissalBlock:^(BOOL dismissedInteractively) {
        isSubmit=NO;
    }];
    [successView show];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buttonSecrecyClick{
    SecrecyViewController *secrecy=[[SecrecyViewController alloc] init];
    [self.navigationController pushViewController:secrecy animated:YES];
    [secrecy release];
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
        TKButtonButtonCell *cell=[[TKButtonButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell.leftButton setTitle:@"存儲" forState:UIControlStateNormal];
        [cell.leftButton addTarget:self action:@selector(buttonSaveClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightButton setTitle:@"隱私及資訊安全保護政策" forState:UIControlStateNormal];
        [cell.rightButton addTarget:self action:@selector(buttonSecrecyClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}
@end
