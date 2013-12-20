//
//  SearchField.m
//  Eland
//
//  Created by aJia on 13/10/2.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "SearchField.h"
#import "UIColor+TPCategory.h"

#import "TKSearchDoubleFieldCell.h"
#import "TKSearchCalendarCell.h"
#import "VillageTownViewController.h"
#import "CaseCategoryViewController.h"
#import "TKSearchEmptyCell.h"
@implementation SearchField
@synthesize cells=_cells;
@synthesize levevlCaseArgs=_levevlCaseArgs;
@synthesize searchArgs;
- (void)dealloc{
    [super dealloc];
    [_tableView release],_tableView=nil;
    [_cells release],_cells=nil;
    [_levevlCaseArgs release],_levevlCaseArgs=nil;
    if (popoverCity) {
        [popoverCity release],popoverCity=nil;
    }
    if (popoverCategory) {
        [popoverCategory release],popoverCategory=nil;
    }
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorFromHexRGB:@"dfdfdf"];
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.bounces=NO;
        _tableView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:_tableView];
        
        _buttonCell=[[TKSearchTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _buttonCell.label.text=@"案件編號";
        
        TKSearchDoubleFieldCell *cell2=[[[TKSearchDoubleFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
        cell2.label.text=@"分類";
        cell2.leftField.popoverTextField.placeholder=@"請選擇分類";
        cell2.leftField.delegate=self;
        cell2.rightLabel.text=@"鄉鎮";
        cell2.rightField.popoverTextField.placeholder=@"請選擇鄉鎮";
        cell2.rightField.delegate=self;
        
        TKSearchCalendarCell *cell3=[[[TKSearchCalendarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
        cell3.label.text=@"日期";
        cell3.rightLabel.text=@"至";
        cell3.startCalendar.popoverText.popoverTextField.placeholder=@"開始日期";
        cell3.endCalendar.popoverText.popoverTextField.placeholder=@"結束日期";
        cell3.startCalendar.datePicker.maximumDate=[NSDate date];
        cell3.endCalendar.datePicker.maximumDate=[NSDate date];
        
        TKSearchEmptyCell *cell4=[[[TKSearchEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
        self.cells=[NSMutableArray arrayWithObjects:_buttonCell,cell2,cell3,cell4, nil];
        
        if (!_levevlCaseArgs) {
            _levevlCaseArgs=[[LevelCaseArgs alloc] init];
            _levevlCaseArgs.Pager=[[Pager alloc] init];
            [self resetLoadingSearch];
        }
    }
    return self;
}
-(void)resetLoadingSearch{
    _levevlCaseArgs.Pager.PageNumber=0;
    _levevlCaseArgs.Pager.PageSize=DeviceIsPad?20:10;
    _levevlCaseArgs.Pager.TotalItemsCount=0;
    _levevlCaseArgs.Pager.TotalPageCount=0;
}
-(void)selectedCaseCategory:(CaseCategory*)category{
    TKSearchDoubleFieldCell *cell=self.cells[1];
    cell.leftField.popoverTextField.text=category.Name;
    if (popoverCategory) {
        [popoverCategory dismissPopoverAnimated:YES];
    }
    _levevlCaseArgs.CaseSettingGuid=category.GUID;
}

-(void)hidePopoverCity{
    if (popoverCity) {
        [popoverCity dismissPopoverAnimated:YES];
    }
}
-(void)selectedVillageTown:(CaseCity*)city{
     TKSearchDoubleFieldCell *cell=self.cells[1];
     cell.rightField.popoverTextField.text=city.Name;
    [self hidePopoverCity];
    _levevlCaseArgs.CityGuid=city.GUID;
}
-(NSString*)searchArgs{
    TKSearchTextFieldCell *cell1=self.cells[0];
    _levevlCaseArgs.GUID=cell1.field.text;
        
    TKSearchCalendarCell *cell2=self.cells[2];
    _levevlCaseArgs.BApplyDate=cell2.startCalendar.popoverText.popoverTextField.text;
    _levevlCaseArgs.EApplyDate=cell2.endCalendar.popoverText.popoverTextField.text;
    
     return [_levevlCaseArgs XmlSerialize];
    /***
    NSString *result=[_levevlCaseArgs XmlSerialize];
    result=[result stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    result=[result stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    return result;
     ***/
}
#pragma mark FPPopoverControllerDelegate
- (void)presentedNewPopoverController:(FPPopoverController *)newPopoverController
          shouldDismissVisiblePopover:(FPPopoverController*)visiblePopoverController
{
    [visiblePopoverController dismissPopoverAnimated:YES];
    [visiblePopoverController autorelease];
}
#pragma mark -
#pragma mark CVUIPopoverTextDelegate Methods
-(void)doneShowPopoverView:(id)sender senderView:(id)view{
    TKSearchDoubleFieldCell *cell=self.cells[1];
    if (cell.leftField==sender) {
        if (!popoverCategory) {
            CaseCategoryViewController *controller=[[[CaseCategoryViewController alloc] init] autorelease];
            controller.delegate=self;
            popoverCategory = [[FPPopoverController alloc] initWithViewController:controller];
            popoverCategory.tint=FPPopoverLightGrayTint;
            popoverCategory.contentSize = CGSizeMake(300, 300);
            popoverCategory.arrowDirection = FPPopoverArrowDirectionAny;
        }
        [popoverCategory presentPopoverFromView:view];
    }
    if(cell.rightField==sender)
    {
        if (!popoverCity) {
            VillageTownViewController *controller=[[[VillageTownViewController alloc] init] autorelease];
            controller.delegate=self;
            popoverCity = [[FPPopoverController alloc] initWithViewController:controller];
            popoverCity.tint=FPPopoverLightGrayTint;
            popoverCity.contentSize = CGSizeMake(200, 300);
            popoverCity.arrowDirection = FPPopoverArrowDirectionAny;
        }
        [popoverCity presentPopoverFromView:view];
        //[popoverCity presentPopoverFromView:view containerView:self];
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

@end
