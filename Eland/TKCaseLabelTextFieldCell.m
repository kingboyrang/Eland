//
//  TKCaseLabelTextFieldCell.m
//  Eland
//
//  Created by aJia on 13/10/17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKCaseLabelTextFieldCell.h"
#import "UIColor+TPCategory.h"
@implementation TKCaseLabelTextFieldCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    _field = [[EMKeyboardBarTextField alloc] initWithFrame:CGRectZero];
	_field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	_field.backgroundColor = [UIColor clearColor];
    _field.font = [UIFont boldSystemFontOfSize:16.0];
    _field.textColor=[UIColor colorFromHexRGB:@"666666"];
    [self.contentView addSubview:_field];
    
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
	
	CGRect r = CGRectInset(self.contentView.bounds, 10, 4);
	r.origin.x += self.label.frame.size.width + 4;
	r.size.width -= self.label.frame.size.width + 4;
	_field.frame = r;
	
	
}

@end
