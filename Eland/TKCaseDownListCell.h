//
//  TKCaseDownListCell.h
//  Eland
//
//  Created by aJia on 2014/1/21.
//  Copyright (c) 2014年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVUISelect.h"
@interface TKCaseDownListCell : UITableViewCell<CVUISelectDelegate>
@property(nonatomic,readonly) BOOL hasValue;
@property(nonatomic,assign) BOOL required;
@property(nonatomic,copy) NSString *LabelName;
@property(nonatomic,assign) id delegate;
@property (nonatomic,strong) CVUISelect *field1;
@property (nonatomic,strong) CVUISelect *field2;
@property(nonatomic,copy) NSString *ParentGUID;
- (void)fillNodesArray;
@end
