//
//  TKCaseRadioCell.h
//  Eland
//
//  Created by aJia on 2013/11/28.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseRadioView.h"
@interface TKCaseRadioCell : UITableViewCell
@property(nonatomic,strong) ChooseRadioView *radioView;
@property(nonatomic,readonly) BOOL hasValue;
@property(nonatomic,assign) BOOL required;
@property(nonatomic,copy) NSString *LabelName;
-(void)setSelectedItemText:(NSString*)txt;
@end
