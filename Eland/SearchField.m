//
//  SearchField.m
//  Eland
//
//  Created by aJia on 13/10/2.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "SearchField.h"
#import "UIColor+TPCategory.h"
#import "TKSearchTextFieldCell.h"
#import "TKSearchDoubleFieldCell.h"
#import "TKSearchCalendarCell.h"
@implementation SearchField
@synthesize cells=_cells;
- (void)dealloc{
    [super dealloc];
    [_tableView release],_tableView=nil;
    [_cells release],_cells=nil;
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
        
        TKSearchTextFieldCell *cell1=[[[TKSearchTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
        cell1.label.text=@"案件編號";
        
        TKSearchDoubleFieldCell *cell2=[[[TKSearchDoubleFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
        cell2.label.text=@"分類";
        cell2.rightLabel.text=@"鄉鎮";
        
        TKSearchCalendarCell *cell3=[[[TKSearchCalendarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
        cell3.label.text=@"日期";
        cell3.rightLabel.text=@"至";
        cell3.startCalendar.popoverText.popoverTextField.placeholder=@"開始日期";
        cell3.endCalendar.popoverText.popoverTextField.placeholder=@"結束日期";
        cell3.startCalendar.datePicker.maximumDate=[NSDate date];
        cell3.endCalendar.datePicker.maximumDate=[NSDate date];
        self.cells=[NSMutableArray arrayWithObjects:cell1,cell2,cell3, nil];
    }
    return self;
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
