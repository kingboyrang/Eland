//
//  TKCaseCalendarCell.h
//  Eland
//
//  Created by aJia on 2013/11/27.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVUICalendar.h"
@interface TKCaseCalendarCell : UITableViewCell
@property(nonatomic,strong) CVUICalendar *lostCalendar;
@property(nonatomic,readonly) BOOL hasValue;
@property(nonatomic,assign) BOOL required;
@property(nonatomic,copy) NSString *LabelName;
@property(nonatomic,copy) NSString *LabelText;
@end
