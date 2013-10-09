//
//  TKSearchTextFieldCell.m
//  Eland
//
//  Created by aJia on 13/10/2.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKSearchTextFieldCell.h"

@implementation TKSearchTextFieldCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    _field = [[EMKeyboardBarTextField alloc] initWithFrame:CGRectZero];
    _field.borderStyle=UITextBorderStyleBezel;
	_field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	_field.backgroundColor = [UIColor whiteColor];
    _field.font = [UIFont boldSystemFontOfSize:16.0];
    _field.delegate=self;
    [self.contentView addSubview:_field];
    
    UIImage *leftImage=[UIImage imageNamed:@"btn.png"];
    UIEdgeInsets leftInsets = UIEdgeInsetsMake(5,10, 5, 10);
    leftImage=[leftImage resizableImageWithCapInsets:leftInsets resizingMode:UIImageResizingModeStretch];
    
    _button=[UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame=CGRectMake(0, 0, 100, 40);
    [_button setBackgroundImage:leftImage forState:UIControlStateNormal];
    _button.titleLabel.font=[UIFont boldSystemFontOfSize:16.0];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button setTitle:@"查詢" forState:UIControlStateNormal];
    [self.contentView addSubview:_button];

    

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
	
	CGRect r = CGRectInset(self.contentView.bounds, 8, 4);
	r.origin.x += self.label.frame.size.width + self.label.frame.origin.x+4;
	r.size.width -= self.label.frame.size.width + 6+self.label.frame.origin.x;
    
    CGRect frame=[_button frame];
    frame.origin.y=(self.bounds.size.height-frame.size.height)/2.0;
    frame.origin.x=r.origin.x+r.size.width-frame.size.width+2;
    _button.frame=frame;
    
    r.size.width-=_button.frame.size.width+2;
    
	_field.frame = r;
}
#pragma mark UITextFieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
	[_field resignFirstResponder];
    return NO;
}

@end
