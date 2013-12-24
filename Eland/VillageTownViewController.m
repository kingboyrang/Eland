//
//  VillageTownViewController.m
//  Eland
//
//  Created by aJia on 13/10/4.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "VillageTownViewController.h"
#import "CacheHelper.h"
#import "CaseCity.h"
#import "ASIHTTPRequest.h"
#import "asyncHelper.h"
#import "CaseCityHelper.h"
@interface VillageTownViewController ()
-(void)updateSourceData:(NSArray*)source;
-(void)showLoading;
-(void)hideLoading;
@end

@implementation VillageTownViewController
@synthesize listData=_listData;
@synthesize delegate;
-(void)dealloc{
    [_listData release];
    [_tableView release],_tableView=nil;
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
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
     self.title=@"鄉鎮";
     currentIndex=-1;
    NSArray *arr=[CacheHelper readCacheCitys];
    if (arr==nil||[arr count]==0) {
        [self showLoading];
        [asyncHelper asyncLoadCity:^(NSArray *result) {
            [self performSelectorOnMainThread:@selector(updateSourceData:) withObject:result waitUntilDone:NO];
        }];
    }else{
        self.listData=[CaseCityHelper sourceFromArray:arr];
        [_tableView reloadData];
    }
	// Do any additional setup after loading the view.
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
    self.listData=[CaseCityHelper sourceFromArray:source];
    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    CaseCity *item=[self.listData objectAtIndex:indexPath.row];
    cell.textLabel.text=item.Name;
    cell.accessoryType=currentIndex==indexPath.row?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    return cell;
}
#pragma mark - Table view delegate
- (void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    int newRow=indexPath.row;
    if(newRow!=currentIndex){
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        if (currentIndex!=-1) {
            NSIndexPath *oldIndexPath=[NSIndexPath indexPathForItem:currentIndex inSection:0];
            UITableViewCell *oldCell=[tableView cellForRowAtIndexPath:oldIndexPath];
            oldCell.accessoryType=UITableViewCellAccessoryNone;
        }
        currentIndex=newRow;
    }
    if (self.delegate&&[self.delegate respondsToSelector:@selector(selectedVillageTown:)]) {
        SEL sel = NSSelectorFromString(@"selectedVillageTown:");
        [self.delegate performSelector:sel withObject:[self.listData objectAtIndex:currentIndex]];
    }
}

@end
