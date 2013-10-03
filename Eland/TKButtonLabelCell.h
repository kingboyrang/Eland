//
//  TKButtonLabelCell.h
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKButtonLabelCell : UITableViewCell
@property(nonatomic,strong) UIButton *button;
@property(nonatomic,strong) UILabel *label;
-(void)setLabelValue:(NSString*)title normal:(BOOL)isNormal;
-(void)startLocation;
@end
