//
//  DownListViewController.m
//  Eland
//
//  Created by aJia on 2014/1/21.
//  Copyright (c) 2014年 rang. All rights reserved.
//

#import "DownListViewController.h"
#import "CacheHelper.h"
#import "CaseCategoryHelper.h"
#import "asyncHelper.h"
@interface DownListViewController (){
    NSUInteger indentation;
    UITableView *_tableView;
}
- (void)fillNodesArray;
-(void)showLoading;
-(void)hideLoading;
-(void)updateSourceData:(NSArray*)source;
@end

@implementation DownListViewController
- (void)dealloc{
    [super dealloc];
    [_tableView release];
    if (HUD) {
        [HUD release],HUD=nil;
    }
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
    self.title=@"分類";
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
	indentation=-1;
    if(!self.defaultLoad)
    {
       [self fillNodesArray];
    }
}
- (void)resetDataSourceWithParentGuid:(NSString*)guid{
    indentation=-1;
    self.ParentGUID=guid;
    [self fillNodesArray];
}
- (void)fillNodesArray{
    CaseCategoryHelper *_helper=[[[CaseCategoryHelper alloc] init] autorelease];
    NSArray *arr=[CacheHelper readCacheCaseCategorys];
    if (arr&&[arr count]>0) {
        _helper.categorys=[NSMutableArray arrayWithArray:arr];
        if (self.ParentGUID&&[self.ParentGUID length]>0) {
            self.list=[_helper childsTreeNodesWithEmpty:self.ParentGUID];//取得子项
        }else{
            self.list=[_helper getTrees];
        }
        [_tableView reloadData];
    }else{
        [self showLoading];
        [asyncHelper asyncLoadCaseCategory:^(NSArray *result) {
            [self performSelectorOnMainThread:@selector(updateSourceData:) withObject:result waitUntilDone:NO];
        }];
    }
}
-(void)updateSourceData:(NSArray*)source{
    [self hideLoading];
    if (source==nil||[source count]==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"加載失敗!";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:3];
    }
    CaseCategoryHelper *_helper=[[[CaseCategoryHelper alloc] init] autorelease];
    _helper.categorys=[NSMutableArray arrayWithArray:source];
    if (self.ParentGUID&&[self.ParentGUID length]>0) {
        self.list=[_helper childsTreeNodesWithEmpty:self.ParentGUID];//取得子项
    }else{
        self.list=[_helper getTrees];
    }
    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setSelectedCategoryIndex:(int)index{
    if(index!=indentation)
    {
        if (self.list&&[self.list count]>0) {
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
            UITableViewCell *cell=[_tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
        }
    }
    indentation=index;
    
}
-(void)showLoading{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
	HUD.delegate = self;
	HUD.labelText = @"正在加載...";
    [HUD show:YES];
}
-(void)hideLoading{
    [HUD hide:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"treeNodeCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    CaseCategory *entity=self.list[indexPath.row];
    cell.textLabel.text=entity.Name;
    cell.accessoryType=indentation==indexPath.row?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    int newRow=indexPath.row;
    if(newRow!=indentation){
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        if (indentation!=-1) {
            NSIndexPath *oldIndexPath=[NSIndexPath indexPathForItem:indentation inSection:0];
            UITableViewCell *oldCell=[tableView cellForRowAtIndexPath:oldIndexPath];
            oldCell.accessoryType=UITableViewCellAccessoryNone;
        }
        indentation=newRow;
    }
    CaseCategory *entity=self.list[indexPath.row];
    //self.selectedCaseCategory=entity;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(selectedCaseCategory:)]) {
        SEL sel = NSSelectorFromString(@"selectedCaseCategory:");
        [self.delegate performSelector:sel withObject:entity];
    }
    if (self.popoverControl&&[self.popoverControl isKindOfClass:[UITextField class]]) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(selectedCaseCategory:sender:)]) {
            [self.delegate performSelector:@selector(selectedCaseCategory:sender:) withObject:entity withObject:self.popoverControl];
        }
    }
}
@end
