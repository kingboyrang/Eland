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
#import "UserSet.h"
#import "AlertHelper.h"
@interface PushViewController (){
    UITableView *_tableView;
}
-(void)loadAndUpdatePush;
-(void)reloadPushInfo;
@end

@implementation PushViewController
-(void)dealloc{
    [super dealloc];
    [_helper release],_helper=nil;
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
    [self reloadPushInfo];
    [self loadAndUpdatePush];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.autoresizesSubviews=YES;
    _tableView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_tableView];
    _helper=[[ServiceHelper alloc] init];
    
	// Do any additional setup after loading the view.
}
-(void)reloadPushInfo{
    NSArray *arr=[CacheHelper readCacheCasePush];
    if (arr&&[arr count]>0) {
        //排序
        NSSortDescriptor *_sorter  = [[NSSortDescriptor alloc] initWithKey:@"SendTime" ascending:NO];
        NSArray *sortArr=[arr sortedArrayUsingDescriptors:[NSArray arrayWithObjects:_sorter, nil]];
        self.listData=[NSMutableArray arrayWithArray:sortArr];
        [_sorter release];
        [_tableView reloadData];
    }
}
-(void)loadAndUpdatePush{
    NSString *token=[[UserSet sharedInstance] AppToken];
    //NSString *token=@"6997eda072e4e60784a108bb9a98a777f737403caaaa2ed22f69580d14a411f5";
    if ([token length]==0)return;
    ServiceArgs *args=[[[ServiceArgs alloc] init] autorelease];
    args.methodName=@"GetMessages";
    args.soapParams=[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:token,@"token", nil], nil];
    [_helper asynService:args success:^(ServiceResult *result) {
        
        if ([result.xmlString length]>0) {
            NSString *xml=[result.xmlString stringByReplacingOccurrencesOfString:result.xmlnsAttr withString:@""];
            [result.xmlParse setDataSource:xml];
            XmlNode *node=[result.xmlParse soapXmlSelectSingleNode:@"//GetMessagesResult"];
            xml=[node.Value stringByReplacingOccurrencesOfString:@"xmlns=\"Push[]\"" withString:@""];
            [result.xmlParse setDataSource:xml];
            NSArray *arr=[result.xmlParse selectNodes:@"//Push" className:@"PushResult"];
            if (arr&&[arr count]>0) {
                [CacheHelper cacheCasePushArray:arr];
                [self reloadPushInfo];
                
            }
        }
        
    } failed:^(NSError *error, NSDictionary *userInfo) {
        
    }];
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
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    PushResult *entity=[self.listData objectAtIndex:indexPath.row];
    PushDetail *pushDetail=(PushDetail*)[cell viewWithTag:100];
    [pushDetail setDataSource:entity];
    return cell;
}
//默认编辑模式为删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger deleteRow=indexPath.row;
    [AlertHelper initWithTitle:@"確定是否刪除?" message:nil cancelTitle:@"取消" cancelAction:nil confirmTitle:@"確定" confirmAction:^{
        PushResult *entity=[[self.listData objectAtIndex:deleteRow] retain];
        [CacheHelper cacheDeletePushWithGuid:entity.GUID];
        [entity release];
        //删除绑定数据
        [self.listData removeObjectAtIndex:deleteRow];
        //重新写入文件中
        [CacheHelper cacheCasePushFromArray:self.listData];
        //行的删除
        NSMutableArray *indexPaths = [NSMutableArray array];
        [indexPaths addObject:[NSIndexPath indexPathForRow:deleteRow inSection:0]];
        [_tableView beginUpdates];
        [_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        [_tableView endUpdates];
        [AlertHelper initWithTitle:@"提示" message:@"刪除成功!"];
    }];
  
    
    
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
