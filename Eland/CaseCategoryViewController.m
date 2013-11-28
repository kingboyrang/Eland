//
//  CaseCategoryViewController.m
//  Eland
//
//  Created by aJia on 13/10/4.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseCategoryViewController.h"
#import "TreeViewNode.h"
#import "TheProjectCell.h"

#import "CacheHelper.h"
#import "CaseCategoryHelper.h"
#import "asyncHelper.h"
@interface CaseCategoryViewController (){
    NSUInteger indentation;
    NSArray *nodes;
    UITableView *_tableView;
}
- (void)expandCollapseNode:(NSNotification *)notification;
- (void)fillDisplayArray;
- (void)fillNodesArray;
- (void)fillNodeWithChildrenArray:(NSArray *)childrenArray;

- (IBAction)expandAll:(id)sender;
- (IBAction)collapseAll:(id)sender;

-(void)updateSourceData:(NSArray*)source;
-(void)showLoading;
-(void)hideLoading;
@end

@implementation CaseCategoryViewController
@synthesize displayArray=_displayArray;
@synthesize delegate;
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [_displayArray release];
    if (nodes) {
        [nodes release];
        nodes=nil;
    }
    [super dealloc];
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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(expandCollapseNode:) name:@"ProjectTreeNodeButtonClicked" object:nil];
    [self fillNodesArray];
   
}
-(void)setSelectedCategoryIndex:(int)index{
    if(index!=indentation)
    {
        if (nodes&&[nodes count]>0) {
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
            UITableViewCell *cell=[_tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
            
             NSLog(@"bb");
            //NSIndexPath *indexPath1=[NSIndexPath indexPathForRow:indentation inSection:0];
            //UITableViewCell *cell1=[_tableView cellForRowAtIndexPath:indexPath1];
            //cell1.accessoryType=UITableViewCellAccessoryNone;
        }
    }
    indentation=index;
    NSLog(@"aa");
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
        nodes=[[_helper fillCategoryTreeNodes:self.ParentGUID] retain];
    }else{
       nodes=[[_helper sourceTreeNodes] retain];
    }
    [self fillDisplayArray];
    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)expandAll:(id)sender
{
    [self fillNodesArray];
    [self fillDisplayArray];
    [_tableView reloadData];
}

- (IBAction)collapseAll:(id)sender
{
    for (TreeViewNode *treeNode in nodes) {
        treeNode.isExpanded = NO;
    }
    [self fillDisplayArray];
    [_tableView reloadData];
}
- (void)fillNodesArray{
    CaseCategoryHelper *_helper=[[[CaseCategoryHelper alloc] init] autorelease];
    NSArray *arr=[CacheHelper readCacheCaseCategorys];
    if (arr&&[arr count]>0) {
        _helper.categorys=[NSMutableArray arrayWithArray:arr];
        if (self.ParentGUID&&[self.ParentGUID length]>0) {
            nodes=[[_helper fillCategoryTreeNodes:self.ParentGUID] retain];
        }else{
             nodes=[[_helper sourceTreeNodes] retain];
        }
        
        [self fillDisplayArray];
        [_tableView reloadData];
    }else{
        [self showLoading];
        [asyncHelper asyncLoadCaseCategory:^(NSArray *result) {
            [self performSelectorOnMainThread:@selector(updateSourceData:) withObject:result waitUntilDone:NO];
        }];
    }
}
- (void)fillDisplayArray
{
    if (!self.displayArray) {
        self.displayArray = [[NSMutableArray alloc] init];
    }
    [self.displayArray removeAllObjects];
    for (TreeViewNode *node in nodes) {
        if (![self.displayArray containsObject:node]) {
            [self.displayArray addObject:node];
        }
        if (node.isExpanded) {
            [self fillNodeWithChildrenArray:node.nodeChildren];
        }
    }
}
- (void)fillNodeWithChildrenArray:(NSArray *)childrenArray
{
    for (TreeViewNode *node in childrenArray) {
        [self.displayArray addObject:node];
        if (node.isExpanded) {
            [self fillNodeWithChildrenArray:node.nodeChildren];
        }
    }
}

#pragma mark - Messages to fill the tree nodes and the display array
//This function is used to expand and collapse the node as a response to the ProjectTreeNodeButtonClicked notification
- (void)expandCollapseNode:(NSNotification *)notification
{
    [self fillDisplayArray];
    [_tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.displayArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"treeNodeCell";
    UINib *nib = [UINib nibWithNibName:@"ProjectCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    TheProjectCell *cell = (TheProjectCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    TreeViewNode *node = [self.displayArray objectAtIndex:indexPath.row];
    cell.treeNode = node;
    CaseCategory *entity=(CaseCategory*)node.nodeObject;
    cell.cellLabel.text =entity.Name;
    if (node.isExpanded) {
        [cell setTheButtonBackgroundImage:[UIImage imageNamed:@"Open"]];
    }
    else {
        [cell setTheButtonBackgroundImage:[UIImage imageNamed:@"Close"]];
    }
    [cell setNeedsDisplay];
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
    TreeViewNode *node = [self.displayArray objectAtIndex:indexPath.row];
    CaseCategory *entity=(CaseCategory*)node.nodeObject;
    //self.selectedCaseCategory=entity;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(selectedCaseCategory:)]) {
        SEL sel = NSSelectorFromString(@"selectedCaseCategory:");
        [self.delegate performSelector:sel withObject:entity];
    }
}
@end
