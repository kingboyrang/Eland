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
#import "Photos.h"
#import "MKPhotoBrowser.h"
#import "TKShowImageCell.h"

#define birthArray [NSArray arrayWithObjects:@"Note1",@"NewbornRelation", nil]
#define marryArray [NSArray arrayWithObjects:@"Note2",@"ManName",@"WoManName",@"ManAddress",@"WoManAddress", nil]
#define dieArray [NSArray arrayWithObjects:@"Note3",@"DeadRelation",@"DeadName",@"DeadAddress", nil]

@interface CaseDetailViewController ()
-(void)loadAsyncDetail;
-(void)updateSoureData;
-(BOOL)existsArrayWithName:(NSString*)name HRType:(int)type;
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
        //图片缓存
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
    NSMutableArray *applicantSource=[NSMutableArray array];
    if (self.entityCase) {
        NSString *memo=@"";
        if (self.entityCase.Applicant) {
            if (self.entityCase.Applicant.Nick&&[self.entityCase.Applicant.Nick length]>0) {
                memo=self.entityCase.Applicant.Nick;
            }
        }
        TKShowLabelLabelCell *cell0=[[TKShowLabelLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell0.label.text=@"案件編號:";
        cell0.rightlabel.text=self.entityCase.GUID;
        [applicantSource addObject:cell0];
        [cell0 release];
        
        TKShowLabelLabelCell *cell3=[[TKShowLabelLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell3.label.text=@"暱稱:";
        cell3.rightlabel.text=memo;
        [applicantSource addObject:cell3];
        [cell3 release];
        
        TKShowLabelLabelCell *cell4=[[TKShowLabelLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell4.label.text=@"辦理情形:";
        cell4.rightlabel.text=[self.entityCase HandlerMemo];
        [applicantSource addObject:cell4];
        [cell4 release];
        
        TKShowLabelLabelCell *cell=[[TKShowLabelLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.label.text=@"狀態:";
        cell.rightlabel.text=[self.entityCase StatusText];
        cell.rightlabel.textColor=[UIColor redColor];
        [applicantSource addObject:cell];
        [cell release];
        
        TKShowLabelLabelCell *cell1=[[TKShowLabelLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell1.label.text=@"項目分類:";
        cell1.rightlabel.text=[self.entityCase CaseCagegoryName];
        [applicantSource addObject:cell1];
        [cell1 release];
       
        TKShowLabelLabelCell *cell2=[[TKShowLabelLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell2.label.text=@"通報日期:";
        cell2.rightlabel.text=[self.entityCase ApplyDateText];
        [applicantSource addObject:cell2];
        [cell2 release];

    }
    
    
    NSMutableArray *arr=[NSMutableArray arrayWithArray:applicantSource];
    NSString *content=@"";
    NSArray *fields=[self.entityCaseSetting sortFields];
    int type=[self.entityCase HRType];
    for (CaseSettingField *item in fields) {
        if ([item.Name startWithString:@"Note"]||[item.Name isEqualToString:@"LngLat"]) {
            continue;
        }
        if ([self.entityCaseSetting.GUID isEqualToString:@"HR"]) {//户政预约
            if (type==1&&[item.Name isEqualToString:@"CityGuid"]) {//出生登記
                item.Label=@"新生兒預約設籍之戶政事務所";
            }
            if (type!=1&&[item.Name isEqualToString:@"CityGuid"]) {//出生登記
                item.Label=@"預約戶籍地之戶政事務所";
            }
            if ([self existsArrayWithName:item.Name HRType:type]) {
                continue;
            }
        }
        //NSLog(@"filed=%@,name=%@,sort=%@",item.Name,item.Label,item.Sort);
        TKShowLabelLabelCell *cell=[[TKShowLabelLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.label.text=[NSString stringWithFormat:@"%@:",item.Label];
        content=[self.entityCase getCaseFieldValue:item.Name];
        if([content length]==0&&item.Text&&[item Text]>0)
            content=item.Text;
        cell.rightlabel.text=content;
        [arr addObject:cell];
        [cell release];
    }
    if (self.entityCaseSetting.showImage&&self.entityCase.Images&&[self.entityCase.Images count]>0) {
        TKShowLabelLabelCell *cell=[[TKShowLabelLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.label.text=@"案件圖片:";
        TKShowImageCell *emptyCell=[[TKShowImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [emptyCell.PhotoScroll addRangeURLs:[self.entityCase imageURLs]];
        [arr addObject:cell];
        [arr addObject:emptyCell];
        [cell release];
        [emptyCell release];
        
    }
    self.cells=arr;
    [_tableView reloadData];
    /***
    if (self.entityCaseSetting.showImage&&self.entityCase.Images&&[self.entityCase.Images count]>0&&[[self.cells lastObject] isKindOfClass:[TKEmptyCell class]]){
        MKPhotoScroll *_photoScroll=[[MKPhotoScroll alloc] initWithFrame:CGRectMake((DeviceWidth-296)/2.0,2, 296, 296)];
        _photoScroll.tag=100;
        _photoScroll.backgroundColor=[UIColor grayColor];
        _photoScroll.delegate=self;
        //_photoScroll.autoresizesSubviews=YES;
        //_photoScroll.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [_photoScroll addRangeURLs:[self.entityCase imageURLs]];
        TKEmptyCell *cell=[self.cells lastObject];
        [cell.contentView addSubview:_photoScroll];
        [_photoScroll release];
    }
     ***/
    //
}
-(BOOL)existsArrayWithName:(NSString*)name HRType:(int)type{
    NSMutableArray *source=[NSMutableArray array];
    if (type==1) {//出生登记
        [source addObjectsFromArray:marryArray];
        [source addObjectsFromArray:dieArray];
    }else if(type==2){//結婚登記
        [source addObjectsFromArray:birthArray];
        [source addObjectsFromArray:dieArray];
    }else{//死亡登記
        [source addObjectsFromArray:birthArray];
        [source addObjectsFromArray:marryArray];
    }
    NSString *match=[NSString stringWithFormat:@"SELF =='%@'",name];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:match];
    NSArray *results = [source filteredArrayUsingPredicate:predicate];
    if (results&&[results count]>0) {
        return YES;
    }
    return NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark MKPhotoScrollDelegate Methods
-(void)imageViewClick:(UIImageView*)imageView imageIndex:(int)index{
    TKEmptyCell *cell=[self.cells lastObject];
    MKPhotoScroll *photoScroll=(MKPhotoScroll*)[cell.contentView viewWithTag:100];
    if (photoScroll) {
        NSArray *source=[photoScroll sourceImages];
        if (source) {
            Photos *photo=[[[Photos alloc] init] autorelease];
            [photo addImages:source];
            photo.photoScroll=photoScroll;
            MKPhotoBrowser *browser=[[[MKPhotoBrowser alloc] initWithDataSource:photo andStartWithPhotoAtIndex:index] autorelease];
            browser.showTrashButton=NO;
            browser.showShareButton=YES;
            UINavigationController *nav=[[[UINavigationController alloc] initWithRootViewController:browser] autorelease];
            [self presentViewController:nav animated:YES completion:nil];
            
        }
    }
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
