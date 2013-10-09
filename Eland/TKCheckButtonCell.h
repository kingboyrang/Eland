//
//  TKCheckButtonCell.h
//  Eland
//
//  Created by aJia on 13/10/9.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKCheckButtonCell : UITableViewCell{
   BOOL isLoading;
}
@property(nonatomic,strong) UIButton *button;
@property(nonatomic,strong) UILabel *label;
-(void)startLocation:(void(^)(BOOL finished))completed;
@end
