//
//  TKButtonButtonCell.m
//  Eland
//
//  Created by aJia on 13/10/1.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKButtonButtonCell.h"
#import "UIColor+TPCategory.h"
#import "UIImage+TPCategory.h"
@implementation TKButtonButtonCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    UIImage *leftImage=[UIImage imageNamed:@"btn.png"];
    UIEdgeInsets leftInsets = UIEdgeInsetsMake(5,10, 5, 10);
    leftImage=[leftImage resizableImageWithCapInsets:leftInsets resizingMode:UIImageResizingModeStretch];
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _leftButton.frame=CGRectMake(0, 2, 100, 40);
    [_leftButton setBackgroundImage:leftImage forState:UIControlStateNormal];
    _leftButton.titleLabel.font=[UIFont boldSystemFontOfSize:16.0];
    [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self.contentView addSubview:_leftButton];
    
    
    UIImage *rightImage=[UIImage imageNamed:@"btn.png"];
    UIEdgeInsets rightInsets = UIEdgeInsetsMake(5,10, 5, 10);
    rightImage=[rightImage resizableImageWithCapInsets:rightInsets resizingMode:UIImageResizingModeStretch];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _rightButton.frame=CGRectZero;
    _rightButton.titleLabel.font=[UIFont boldSystemFontOfSize:16.0];
     [_rightButton setBackgroundImage:rightImage forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self.contentView addSubview:_rightButton];

    UIView *tempView = [[[UIView alloc] init] autorelease];
    [self setBackgroundView:tempView];
    [self setBackgroundColor:[UIColor clearColor]];
    
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void) layoutSubviews {
    [super layoutSubviews];
    CGRect r = CGRectInset(self.contentView.bounds, 8, 2);
	r.origin.x += self.leftButton.frame.size.width + 6;
	r.size.width -= self.leftButton.frame.size.width ;
    
	_rightButton.frame = r;
    
}
@end
