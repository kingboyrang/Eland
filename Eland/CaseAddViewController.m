//
//  CaseAddViewController.m
//  Eland
//
//  Created by aJia on 13/10/17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseAddViewController.h"
#import "ASIHTTPRequest.h"
#import "TKCaseLabelCell.h"
#import "TKCaseTextFieldCell.h"
#import "TKCaseTextViewCell.h"
#import "TKCaseTextCell.h"
#import "NSString+TPCategory.h"
#import "TKEmptyCell.h"
#import "TKCaseLabelTextFieldCell.h"
#import "TKCaseButtonCell.h"
#import "CaseSettingField.h"
#import "UIColor+TPCategory.h"
@interface CaseAddViewController ()
-(void)loadingFormFields;
-(void)updateFormUI;
@end

@implementation CaseAddViewController
-(void)dealloc{
    [super dealloc];
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
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.bounces=NO;
    _tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_tableView];
    
    
    //self.cells=[self CaseCategoryAndCityCells:self.Entity];
	[self loadingFormFields];
}
-(void)updateFormUI{
    [self showLoadingSuccessStatus:@"加載完成!"];
    NSMutableArray *source=[NSMutableArray array];
    [source addObjectsFromArray:[self CaseCategoryAndCityCells:self.Entity]];
    if (self.Entity.Fields&&[self.Entity.Fields count]>0) {
        for (CaseSettingField *item in self.Entity.Fields) {
            if ([item.Name isEqualToString:@"Note"]) {
                [source addObjectsFromArray:[self CaseCategoryNoteCells:item]];
                continue;
            }
            if ([item isTextArea]) {
                [source addObjectsFromArray:[self CaseCategoryTextAreaCells:item]];
                continue;
            }
            [source addObjectsFromArray:[self CaseCategoryTextCells:item]];
        }
    }
    TKCaseButtonCell *cell=[[[TKCaseButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [source addObject:cell];
    self.cells=source;
    [_tableView reloadData];
}
-(void)loadingFormFields{
    [self showLoadingStatus:@"正在加載..."];
    NSString *url=[NSString stringWithFormat:SingleCaseSettingURL,self.Entity.GUID];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [request setCompletionBlock:^{
        if (request.responseStatusCode==200) {
            self.Entity=[CaseSetting xmlStringToCaseSetting:request.responseString];
        }
        [self performSelectorOnMainThread:@selector(updateFormUI) withObject:nil waitUntilDone:NO];
       
    }];
    [request setFailedBlock:^{
        [self performSelectorOnMainThread:@selector(updateFormUI) withObject:nil waitUntilDone:NO];
    }];
    [request startAsynchronous];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)selectedCaseCategory:(CaseCategory*)category{
    [self hidePopoverCaseCategory];
    TKCaseTextFieldCell *cell=self.cells[1];
    cell.field.text=category.Name;
}
-(void)selectedVillageTown:(CaseCity*)city{
    [self hidePopoverCaseCity];
    TKCaseTextFieldCell *cell=self.cells[3];
    cell.field.text=city.Name;
}
#pragma mark -
#pragma mark UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return self.cells.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *tableCell=self.cells[indexPath.row];
    tableCell.selectionStyle=UITableViewCellSelectionStyleNone;
    return tableCell;
}
#pragma mark -
#pragma mark UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        if ([self.cells[indexPath.row] isKindOfClass:[TKCaseTextCell class]]) {
            TKCaseTextCell *cell=self.cells[indexPath.row];
            CGSize size=[cell.label.text textSize:[UIFont boldSystemFontOfSize:16.0] withWidth:self.view.bounds.size.width-2*10];
            return size.height+8;
        }
        if ([self.cells[indexPath.row] isKindOfClass:[TKCaseTextViewCell class]]) {
            return 120;
        }
        if ([self.cells[indexPath.row] isKindOfClass:[TKEmptyCell class]]) {
            return 300;
        }
    if ([self.cells[indexPath.row] isKindOfClass:[TKCaseButtonCell class]]) {
        return 44.0;
    }
        if (indexPath.row%2==0) {
            if (![self.cells[indexPath.row] isKindOfClass:[TKCaseLabelTextFieldCell class]]) {
                return 30;
            }
        }
        return 44.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.row==1) {
            TKCaseTextFieldCell *cell=self.cells[1];
            [self buttonCaseCategoryClick:cell CaseCategoryGUID:self.Entity.GUID];
        }
        if (indexPath.row==3) {
            if (self.Entity.showCityDown) {
                TKCaseTextFieldCell *cell=self.cells[3];
                [self buttonCaseCityClick:cell];
            }
        }
    
}
@end
