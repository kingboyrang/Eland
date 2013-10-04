//
//  TKSearchDoubleFieldCell.h
//  Eland
//
//  Created by aJia on 13/10/2.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKSearchLabelCell.h"
#import "CVUIPopoverText.h"
@interface TKSearchDoubleFieldCell : TKSearchLabelCell
@property (nonatomic,strong) CVUIPopoverText *leftField;
@property (nonatomic,strong) CVUIPopoverText *rightField;
@property (nonatomic,strong) UILabel *rightLabel;
@end
