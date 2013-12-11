//
//  TKCaseDropListCell.h
//  Eland
//
//  Created by aJia on 2013/12/11.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVUISelect.h"
@interface TKCaseDropListCell : UITableViewCell
@property(nonatomic,strong) CVUISelect *select;
@property(nonatomic,readonly) BOOL hasValue;
@property(nonatomic,assign) BOOL required;
@property(nonatomic,copy) NSString *LabelName;
@property(nonatomic,copy) NSString *LabelText;
@end
