//
//  TKSearchTextFieldCell.h
//  Eland
//
//  Created by aJia on 13/10/2.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKSearchLabelCell.h"
#import "EMKeyboardBarTextField.h"
@interface TKSearchTextFieldCell : TKSearchLabelCell<UITextFieldDelegate>
@property (nonatomic,strong) EMKeyboardBarTextField *field;
@end
