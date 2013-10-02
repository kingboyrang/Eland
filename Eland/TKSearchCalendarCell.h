//
//  TKSearchCalendarCell.h
//  Eland
//
//  Created by aJia on 13/10/2.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKSearchLabelCell.h"
#import "CVUICalendar.h"
@interface TKSearchCalendarCell : TKSearchLabelCell
@property (nonatomic,strong) CVUICalendar *startCalendar;
@property (nonatomic,strong) CVUICalendar *endCalendar;
@property (nonatomic,strong) UILabel *rightLabel;
@end
