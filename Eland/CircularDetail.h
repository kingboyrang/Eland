//
//  CircularDetail.h
//  CellDemo
//
//  Created by rang on 13-8-31.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LevelCase;
@interface CircularDetail : UIView{
@private
    UIView *innerView;
    UIImageView *_imageView;
}
@property(nonatomic,retain) UILabel *labTitle;
@property(nonatomic,retain) UILabel *labNumber;
@property(nonatomic,retain) UILabel *labCategory;
@property(nonatomic,retain) UILabel *labTime;
@property(nonatomic,retain) UILabel *labStatus;
-(id)initWithTitle:(NSString*)title frame:(CGRect)frame;
-(void)setDataSource:(LevelCase*)args;
-(void)selectedBgColorAnimal:(BOOL)animal;
@end
