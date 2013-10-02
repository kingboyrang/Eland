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
	r.origin.x += self.label.frame.size.width + self.label.frame.origin.x+6;
	r.size.width -= self.label.frame.size.width + 6+self.label.frame.origin.x;
	_field.frame = r;
}
#pragma mark UITextFieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
	[_field resignFirstResponder];
    return NO;
}

@end
