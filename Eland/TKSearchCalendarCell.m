//
//  TKSearchCalendarCell.m
//  Eland
//
//  Created by aJia on 13/10/2.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKSearchCalendarCell.h"
#import "UIColor+TPCategory.h"
@implementation TKSearchCalendarCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    _rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _rightLabel.backgroundColor = [UIColor clearColor];
    _rightLabel.textAlignment = NSTextAlignmentCenter;
    _rightLabel.textColor = [UIColor colorFromHexRGB:@"3db5c0"];
    _rightLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [self.contentView addSubview:_rightLabel];
    
    
    _startCalendar = [[CVUICalendar alloc] initWithFrame:CGRectZero];
    _startCalendar.popoverText.popoverTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _startCalendar.popoverText.popoverTextField.borderStyle=UITextBorderStyleBezel;
    _startCalendar.popoverText.popoverTextField.backgroundColor = [UIColor whiteColor];
    _startCalendar.popoverText.popoverTextField.font = [UIFont boldSystemFontOfSize:16.0];
    [self.contentView addSubview:_startCalendar];
    
    
    _endCalendar = [[CVUICalendar alloc] initWithFrame:CGRectZero];
    _endCalendar.popoverText.popoverTextField.borderStyle=UITextBorderStyleBezel;
    _endCalendar.popoverText.popoverTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _endCalendar.popoverText.popoverTextField.backgroundColor = [UIColor whiteColor];
    _endCalendar.popoverText.popoverTextField.font = [UIFont boldSystemFontOfSize:16.0];
    [self.contentView addSubview:_endCalendar];
    
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
	_startCalendar.frame = r;
    
    r.origin.x=_rightLabel.frame.origin.x+_rightLabel.frame.size.width+2;
    _endCalendar.frame=r;
}

@end
