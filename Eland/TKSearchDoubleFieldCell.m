//
//  TKSearchDoubleFieldCell.m
//  Eland
//
//  Created by aJia on 13/10/2.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKSearchDoubleFieldCell.h"
#import "UIColor+TPCategory.h"
@implementation TKSearchDoubleFieldCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.textColor = [UIColor colorFromHexRGB:@"3db5c0"];
        _rightLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [self.contentView addSubview:_rightLabel];
        
        
        _leftField = [[CVUIPopoverText alloc] initWithFrame:CGRectZero];
        _leftField.popoverTextField.borderStyle=UITextBorderStyleBezel;
        _leftField.popoverTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _leftField.backgroundColor = [UIColor whiteColor];
        _leftField.popoverTextField.font = [UIFont boldSystemFontOfSize:16.0];
        [self.contentView addSubview:_leftField];
    
   
    
    
        _rightField = [[CVUIPopoverText alloc] initWithFrame:CGRectZero];
        _rightField.popoverTextField.borderStyle=UITextBorderStyleBezel;
        _rightField.popoverTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _rightField.backgroundColor = [UIColor whiteColor];
        _rightField.popoverTextField.font = [UIFont boldSystemFontOfSize:16.0];
        [self.contentView addSubview:_rightField];
    
       
       
    
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
    
    CGFloat w=0;
    CGRect frame=[self.label frame];
    w=(self.frame.size.width-frame.size.width*2-frame.origin.x)/2;
    frame.origin.x+=frame.size.width+w;
    _rightLabel.frame=frame;
	
	CGRect r = CGRectInset(self.contentView.bounds, 8, 4);
	r.origin.x = self.label.frame.size.width + self.label.frame.origin.x+4;
	r.size.width = w-9;
	_leftField.frame = r;
    
  
    
    r.origin.x=_rightLabel.frame.origin.x+_rightLabel.frame.size.width+2;
    _rightField.frame=r;    

   
}
@end
