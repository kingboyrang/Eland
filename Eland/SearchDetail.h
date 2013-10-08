//
//  SearchDetail.h
//  Eland
//
//  Created by rang on 13-10-8.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LevelCase.h"
@interface SearchDetail : UIView
@property(nonatomic,strong) UILabel *labNick;
@property(nonatomic,strong) UILabel *labNumber;
@property(nonatomic,strong) UILabel *labCategory;
@property(nonatomic,strong) UILabel *labApplyDate;
@property(nonatomic,strong) UILabel *labStatus;
-(void)setDataSource:(LevelCase*)args;
@end
