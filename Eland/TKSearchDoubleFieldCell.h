//
//  TKSearchDoubleFieldCell.h
//  Eland
//
//  Created by aJia on 13/10/2.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKSearchLabelCell.h"
#import "EMKeyboardBarTextField.h"
@interface TKSearchDoubleFieldCell : TKSearchLabelCell<UITextFieldDelegate>
@property (nonatomic,strong) EMKeyboardBarTextField *leftField;
@property (nonatomic,strong) EMKeyboardBarTextField *rightField;
@property (nonatomic,strong) UILabel *rightLabel;
@end
