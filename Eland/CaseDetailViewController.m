//
//  CaseDetailViewController.m
//  Eland
//
//  Created by aJia on 13/10/7.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseDetailViewController.h"
#import "ASIHTTPRequest.h"
#import "Case.h"
#import "WBInfoNoticeView.h"
#import "CaseSetting.h"
#import "TKShowLabelLabelCell.h"
#import "TKEmptyCell.h"
#import "NSString+TPCategory.h"
@interface CaseDetailViewController ()
-(void)loadAsyncDetail;
-(void)updateSoureData;
@end

@implementation CaseDetailViewController
@synthesize itemCase=_itemCase;
@synthesize entityCase=_entityCase;
@synthesize entityCaseSetting=_entityCaseSetting;
@synthesize cells=_cells;
//@synthesize cellHeights=_cellHeights;
-(void)dealloc{
    [super dealloc];
    [_serviceHelper release],_serviceHelper=nil;
    [_tableView release],_tableView=nil;
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
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.bounces=NO;
    _tableView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_tableView];
    
    [self loadAsyncDetail];
}
-(void)loadAsyncDetail{
    _serviceHelper=[[ServiceHelper alloc] init];
    NSString *urlString=[NSString stringWithFormat:SingleCaseSettingURL,self.itemCase.CaseSettingGuid];
    ASIHTTPRequest *httprequest=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]];
    [httprequest setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"CaseSetting",@"name", nil]];
    [_serviceHelper addQueue:httprequest];
    
    NSString *webURL=[NSString stringWithFormat:SingleCaseURL,self.itemCase.GUID,self.itemCase.PWD];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:webURL]];
    [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Case",@"name", nil]];
    [_serviceHelper addQueue:request];
    
    [_serviceHelper startQueue:^(ServiceResult *result) {
        NSString *name=[result.request.userInfo objectForKey:@"name"];
        if (result.request.responseStatusCode==200) {
            if ([name isEqualToString:@"CaseSetting"]) {
                self.entityCaseSetting=[CaseSetting xmlStringToCaseSetting:result.xmlString];
            }else{
                self.entityCase=[Case xmlStringToCase:result.xmlString];
            }
        }
    } failed:^(NSError *error, NSDictionary *userInfo) {
        
    } complete:^{
        if (_entityCaseSetting.Fields==nil||_entityCaseSetting.Fields.count==0) {
            WBInfoNoticeView *info=[WBInfoNoticeView infoNoticeInView:self.view title:@"服務請求未響應!"];
            [info show];
        }else{//更新数据
            [self performSelectorOnMainThread:@selector(updateSoureData) withObject:nil waitUntilDone:NO];
        }
    }];
}
-(void)updateSoureData{
    NSMutableArray *arr=[NSMutableArray array];
    for (CaseSettingField *item in self.entityCaseSetting.Fields) {
        TKShowLabelLabelCell *cell=[[TKShowLabelLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.label.text=item.Label;
        cell.rightlabel.text=[self.entityCase getFieldValue:item.Name];
        [arr addObject:cell];
        [cell release];
    }
    if (self.entityCaseSetting.showImage) {
        TKShowLabelLabelCell *cell=[[TKShowLabelLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.label.text=@"案件圖片";
        TKEmptyCell *emptyCell=[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [arr addObject:cell];
        [arr addObject:emptyCell];
        [cell release];
        [emptyCell release];
    }
    self.cells=arr;
    [_tableView reloadData];
    
    if (self.entityCase.Images&&self.entityCase.Images.count>0) {
        CaseImage *entity=self.entityCase.Images[0];
        NSLog(@"content=%@",entity.Content);
        NSLog(@"path=%@",entity.Path);
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cells.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *tableCell=self.cells[indexPath.row];
    tableCell.selectionStyle=UITableViewCellSelectionStyleNone;
    return tableCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.cells[indexPath.row] isKindOfClass:[TKShowLabelLabelCell class]]) {
        TKShowLabelLabelCell *cell=self.cells[indexPath.row];
        CGSize leftSize=[cell.label.text textSize:[UIFont boldSystemFontOfSize:16] withWidth:self.view.bounds.size.width];
        CGSize size=[cell.rightlabel.text textSize:[UIFont boldSystemFontOfSize:16] withWidth:self.view.bounds.size.width-leftSize.width-6-16];
        if (size.height>28) {
            return size.height+8*2;
        }
        return 44.0;
    }
    return 300;
}
@end
