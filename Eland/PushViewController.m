//
//  PushViewController.m
//  Eland
//
//  Created by rang on 13-9-29.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "PushViewController.h"
#import "CacheHelper.h"
#import "PushDetail.h"
#import "PushDetailViewController.h"
@interface PushViewController (){
    UITableView *_tableView;
}
@end

@implementation PushViewController

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
    NSArray *arr=[CacheHelper readCacheCasePush];
    if (arr&&[arr count]>0) {
        //排序
        NSSortDescriptor *_sorter  = [[NSSortDescriptor alloc] initWithKey:@"Created" ascending:NO];
        NSArray *sortArr=[arr sortedArrayUsingDescriptors:[NSArray arrayWithObjects:_sorter, nil]];
        self.listData=[NSMutableArray arrayWithArray:sortArr];
        [_sorter release];
        [_tableView reloadData];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
	// Do any additional setup after loading the view.
}
-(void)relayout:(BOOL)isLand{

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellPushIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        PushDetail *detail=[[PushDetail alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 53)];
        detail.tag=100;
        [cell.contentView addSubview:detail];
        [detail release];
    }
    PushResult *entity=[self.listData objectAtIndex:indexPath.row];
    PushDetail *pushDetail=(PushDetail*)[cell viewWithTag:100];
    [pushDetail setDataSource:entity];
    return cell;
}
//默认编辑模式为删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    /***
    NSInteger deleteRow=indexPath.row;
    [AlterMessage initWithTip:@"確定是否刪除?" confirmMessage:@"確定" cancelMessage:@"取消" confirmAction:^(){
        //删除绑定数据
        [self.listData removeObjectAtIndex:deleteRow];
        //重新写入文件中
        [FileHelper ContentToFile:self.listData withFileName:@"Push.plist"];
        //行的删除
        NSMutableArray *indexPaths = [NSMutableArray array];
        [indexPaths addObject:[NSIndexPath indexPathForRow:deleteRow inSection:0]];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
        [AlterMessage initWithMessage:@"刪除成功!"];
        
    }];
     ***/
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 53.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PushDetailViewController *controller=[[PushDetailViewController alloc] init];
    controller.Entity=[self.listData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}
@end
