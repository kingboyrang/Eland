//
//  CaseSearchViewController.m
//  Eland
//
//  Created by rang on 13-9-29.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseSearchViewController.h"
#import "SearchField.h"
#import "ASIHTTPRequest.h"
#import "WBInfoNoticeView.h"
#import "XmlParseHelper.h"
#import "TPSearchCell.h"
#import "LevelCase.h"
#import "AlertHelper.h"
#import "ShakingAlertView.h"
#import "CaseDetailViewController.h"
#import "ASIFormDataRequest.h"
#import "WBSuccessNoticeView.h"
@interface CaseSearchViewController (){
    SearchField *_searchField;
}
-(void)loadData;
-(void)showFailedPasswordAlert:(LevelCase*)entity failure:(void (^)(void))failed;
@end

@implementation CaseSearchViewController
@synthesize refreshing;
@synthesize list=_list;
-(void)dealloc{
    [super dealloc];
    [_tableView release],_tableView=nil;
    [_searchField release],_searchField=nil;
    [_list release];
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
    CGFloat h=44*3;
    _searchField=[[SearchField alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, h)];
    _searchField.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_searchField];
    
    _tableView =[[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, h, self.view.bounds.size.width,self.view.bounds.size.height-h-44*2-44) pullingDelegate:self];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //_tableView.backgroundColor=[UIColor colorWithRed:243/255.0 green:239/255.0 blue:228/255.0 alpha:1.0];
    [self.view addSubview:_tableView];
    
     //self.view.backgroundColor=[UIColor colorWithRed:243/255.0 green:239/255.0 blue:228/255.0 alpha:1.0];
	// Do any additional setup after loading the view.
}
-(void)relayout:(BOOL)isLand{

}
-(void)loadingSource{
    if (_searchField.levevlCaseArgs.Pager.PageNumber==0){
        [_tableView launchRefreshing];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark 密码验证
-(void)showAlterViewPassword:(LevelCase*)entity success:(void (^)(void))completed{
    ShakingAlertView *alter=[[ShakingAlertView alloc] initWithAlertTitle:@"案件密碼"
                                                        checkForPassword:entity.PWD
                                                       onCorrectPassword:^{
                                                           if (completed) {
                                                               completed();
                                                           }
                                                       }
                                              onDismissalWithoutPassword:^{
                                                  [self showFailedPasswordAlert:entity failure:completed];
                                              }];
    [alter show];
    [alter release];
}
-(void)showFailedPasswordAlert:(LevelCase*)entity failure:(void (^)(void))failed{
    [AlertHelper initWithTitle:@"密碼錯誤" message:@"是否再試一次?" cancelTitle:@"取消" cancelAction:nil confirmTitle:@"確認" confirmAction:^{
        [self showAlterViewPassword:entity success:failed];
    }];
}
#pragma mark -
#pragma mark UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CellCircularIdentifier";
    TPSearchCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[[TPSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    LevelCase *entity=[self.list objectAtIndex:indexPath.row];
    [cell setDataSource:entity];
    return cell;

}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 129;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TPSearchCell *cell=(TPSearchCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell selectedCellAnimal:^{
        LevelCase *entity=(LevelCase*)[self.list objectAtIndex:indexPath.row];
        [self showAlterViewPassword:entity success:^{
            //表示成功了
            CaseDetailViewController *detail=[[CaseDetailViewController alloc] init];
            detail.itemCase=entity;
            [self.navigationController pushViewController:detail animated:YES];
            [detail release];
        }];
    }];
}
#pragma mark -
#pragma mark 加载数据
-(void)loadData{
    _searchField.levevlCaseArgs.Pager.PageNumber++;
    NSURL *url=[NSURL URLWithString:CaseSearchURL];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[_searchField searchArgs] forKey:@"xml"];
    [request setRequestMethod:@"POST"];
    [request setCompletionBlock:^{
        if(request.responseStatusCode!=200){
            [_tableView tableViewDidFinishedLoading];
            _tableView.reachedTheEnd  = NO;
            _searchField.levevlCaseArgs.Pager.PageNumber--;
            WBInfoNoticeView *info=[WBInfoNoticeView infoNoticeInView:self.view title:@"服務沒有返回數據!"];
            [info show];
            return;
        }
        NSString *xmlStr=[request.responseString stringByReplacingOccurrencesOfString:@"xmlns=\"LevelCase[]\"" withString:@""];
        NSArray *strArr=[xmlStr componentsSeparatedByString:@"<;>"];
        NSString *xml=[strArr objectAtIndex:1];
        int itemCount=[strArr[0] intValue];
        _searchField.levevlCaseArgs.Pager.TotalItemsCount=itemCount;
        if (self.refreshing) {
            self.refreshing = NO;
        }
        if (_searchField.levevlCaseArgs.Pager.PageNumber>=_searchField.levevlCaseArgs.Pager.TotalPageCount) {
            [_tableView tableViewDidFinishedLoadingWithMessage:@"沒有了哦..."];
            _tableView.reachedTheEnd  = YES;
        } else {
            [_tableView tableViewDidFinishedLoading];
            _tableView.reachedTheEnd  = NO;
            XmlParseHelper *parse=[[[XmlParseHelper alloc] initWithData:xml] autorelease];
            NSArray *result=[parse selectNodes:@"//LevelCase" className:@"LevelCase"];
            if (_searchField.levevlCaseArgs.Pager.PageNumber==1) {
                self.list=[NSMutableArray arrayWithArray:result];
                [_tableView reloadData];
            }else{
                NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:10];
                for (int i=0; i<[result count]; i++) {
                    [self.list addObject:[result objectAtIndex:i]];
                    NSIndexPath *newPath=[NSIndexPath indexPathForRow:(_searchField.levevlCaseArgs.Pager.PageNumber-1)*_searchField.levevlCaseArgs.Pager.PageSize+i inSection:0];
                    [insertIndexPaths addObject:newPath];
                }
                //重新呼叫UITableView的方法, 來生成行.
                [_tableView beginUpdates];
                [_tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
                [_tableView endUpdates];
            }
            WBSuccessNoticeView *successView=[WBSuccessNoticeView successNoticeInView:self.view title:[NSString stringWithFormat:@"當前更新%d數據!",result.count]];
            [successView show];
        }
        //
       
    }];
    [request setFailedBlock:^{
        _searchField.levevlCaseArgs.Pager.PageNumber--;
        self.refreshing = NO;
        [_tableView tableViewDidFinishedLoading];
         WBInfoNoticeView *info=[WBInfoNoticeView infoNoticeInView:self.view title:@"服務沒有返回數據!"];
        [info show];
    }];
    [request startAsynchronous];
}
#pragma mark - PullingRefreshTableViewDelegate
//下拉加载
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    self.refreshing = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

//上拉加载
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_tableView tableViewDidEndDragging:scrollView];
}
@end
