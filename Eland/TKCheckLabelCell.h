//
//  TKCheckLabelCell.h
//  Eland
//
//  Created by aJia on 13/10/9.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKCheckLabelCell : UITableViewCell
@property(nonatomic,strong) UILabel *leftLabel;
@property(nonatomic,strong) UILabel *rightLabel;
-(void)setLabelValue:(NSString*)title normal:(BOOL)isNormal;
@end
