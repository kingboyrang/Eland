//
//  LinearView.h
//  Eland
//
//  Created by aJia on 13/9/24.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LinearView : UIView
@property(nonatomic,retain) UIColor *linarStartColor;
@property(nonatomic,retain) UIColor *linarEndColor;
-(void)setStartLinarColor:(UIColor*)startColor endColor:(UIColor*)endColor;
@end
